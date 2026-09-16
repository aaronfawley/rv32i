TOP := decoder

sim:
	verilator --cc --exe --build --trace rtl/$(TOP).v tb/tb_$(TOP).cpp
	./obj_dir/V$(TOP)

wave: sim
	gtkwave dump.vcd &

clean:
	rm -rf obj_dir dump.vcd
