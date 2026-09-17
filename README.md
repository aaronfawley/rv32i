# rv32i

A single-cycle RISC-V (RV32I) processor written from scratch in Verilog, with
per-module testbenches in C++ under Verilator.

The design was built module by module directly from the RISC-V unprivileged ISA
specification — instruction encodings, immediate formats, and control signal
values were derived from the spec rather than copied from a reference core.

## Status

A working subset of RV32I. The datapath is complete: fetch, decode, register
file, ALU, immediate generation, data memory, operand and writeback muxes, and
conditional branching all function in the assembled core.

| Instruction | Status |
|---|---|
| `addi` | Executes |
| `add`  | Executes |
| `beq`  | Executes — verified taking a forward branch |
| `lw`   | Executes |
| `sw`   | Executes |

The ALU implements all ten RV32I arithmetic and logic operations (add, sub,
and, or, xor, sll, srl, sra, slt, sltu), and the immediate generator handles all
five immediate formats (I, S, B, U, J), including the non-contiguous B-type and
J-type encodings. Both are verified by their own testbenches; the decoder does
not yet select all of them.

## Modules

| File | Role |
|---|---|
| `rtl/pc.v` | Program counter. Adds 4, or loads a branch target. |
| `rtl/imem.v` | Instruction memory. 256 words, preloaded with `$readmemh`. |
| `rtl/regfile.v` | 32 x 32-bit registers. Two read ports, one write port, `x0` hardwired to zero. |
| `rtl/decoder.v` | Opcode to control signals. |
| `rtl/immgen.v` | Extracts and sign-extends immediates for all five formats. |
| `rtl/alu.v` | Ten-operation combinational ALU with a zero flag. |
| `rtl/dmem.v` | Data memory. 256 words, combinational read, clocked write. |
| `rtl/cpu.v` | Top level. Wires the above together and holds the two muxes. |

Each module has a matching self-checking testbench in `tb/`.

## Building and running

Requires Verilator and, optionally, GTKWave.

```bash
sudo apt install verilator gtkwave
```

Build and run the full core:

```bash
verilator --cc --exe --build --trace -Irtl rtl/cpu.v tb/tb_cpu.cpp && ./obj_dir/Vcpu
```

Build and run a single module's testbench — substitute the module name:

```bash
verilator --cc --exe --build --trace rtl/alu.v tb/tb_alu.cpp && ./obj_dir/Valu
```

Lint without building:

```bash
verilator --lint-only -Wall -Irtl rtl/cpu.v
```

## Running a program

`imem.v` loads `tests/program.hex` at simulation start — one 32-bit instruction
per line, in hex, no `0x` prefix.

To produce one from assembly:

```bash
riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 -o tests/prog.o tests/prog.s
riscv64-unknown-elf-objdump -d tests/prog.o
```

The hex column of the disassembly is what goes into `program.hex`. The
`-march=rv32i` flag matters — without it the assembler may emit 64-bit or
compressed instructions the core cannot execute.

## Verification

Every module has a self-checking testbench that reports pass/fail per case and
exits non-zero on failure. Tests target the cases where a plausible but wrong
implementation diverges from a correct one, rather than only the happy path:

- Signed vs. unsigned comparison (`slt` and `sltu` given `0xFFFFFFFF` and `1`
  must return opposite answers)
- Arithmetic vs. logical right shift (`sra` on `0x80000000` must sign-extend)
- Shift amounts above 31, confirming truncation to the low 5 bits
- `x0` reading zero both before any write and after a write to it
- Sub-word addresses aliasing to the same memory word
- Write-enable actually gating writes in both memories

## Known limitations

- Word-addressed memory only. `lb`, `lh`, `sb`, and `sh` are not implemented,
  and the low two bits of every address are discarded.
- The decoder switches on the opcode alone, so instructions sharing an opcode
  (`sub`, `andi`, `xori`, and so on) are not yet distinguished. Adding them
  requires decoding `funct3` and `funct7`.
- Memories are 256 words each, so addresses above `0x3FF` wrap.
- No CSRs, no exceptions, no interrupts.
- Single-cycle, so the clock period is bounded by the slowest instruction path.
  Not pipelined.

## Toolchain

Verilator 5.032 for simulation, GTKWave for waveform inspection, and
`riscv64-unknown-elf-as` / `objdump` for assembling test programs. Developed on
Ubuntu under WSL.
