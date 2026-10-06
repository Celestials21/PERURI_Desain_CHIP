# Makefile untuk menjalankan simulasi cocotb
TOPLEVEL_LANG = vhdl

VHDL_SOURCES = $(PWD)/../src/cordic_stage.vhd

TOPLEVEL = cordic_stage
MODULE = test_cordic

# Gunakan GHDL atau simulator lain jika ada (contoh: SIM=ghdl)
SIM ?= ghdl

include $(shell cocotb-config --makefiles)/Makefile.sim
