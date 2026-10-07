addi x1, x0, 12
andi x2, x1, 10      # 1100 & 1010 = 8
ori  x3, x1, 10      # = 14
xori x4, x1, 10      # = 6
slli x5, x1, 2       # 12 << 2 = 48
srli x6, x1, 2       # = 3
slti x7, x1, 20      # 12 < 20 → 1
addi x8, x0, -5      # negative immediate, should give fffffffb
