import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
import numpy as np

@cocotb.test()
async def cordic_basic_test(dut):
    """Testbench Cocotb untuk memverifikasi modul cordic_stage"""
    
    # Inisialisasi clock 50 MHz
    clock = Clock(dut.clk, 20, units="ns")
    cocotb.start_soon(clock.start())
    
    # Inisialisasi input awal
    dut.x_in.value = 100
    dut.y_in.value = 50
    dut.z_in.value = 0
    dut.atan_val.value = 45 # Nilai dummy untuk atan pada LUT
    
    # Tunggu beberapa siklus clock
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    dut._log.info(f"Input: x={dut.x_in.value.signed_integer}, y={dut.y_in.value.signed_integer}")
    
    await RisingEdge(dut.clk)
    
    # Cek output (simulasi operasi add/shift 1 stage)
    x_out = dut.x_out.value.signed_integer
    y_out = dut.y_out.value.signed_integer
    z_out = dut.z_out.value.signed_integer
    
    dut._log.info(f"Output: x={x_out}, y={y_out}, z={z_out}")
    
    # Verifikasi assert sesuai golden model Python (mode vectoring)
    if 50 >= 0:
        expected_x = 100 + (50 >> 0)
        expected_y = 50 - (100 >> 0)
        expected_z = 0 + 45
    else:
        expected_x = 100 - (50 >> 0)
        expected_y = 50 + (100 >> 0)
        expected_z = 0 - 45
        
    assert x_out == expected_x, f"Error X: Expected {expected_x}, got {x_out}"
    assert y_out == expected_y, f"Error Y: Expected {expected_y}, got {y_out}"
    assert z_out == expected_z, f"Error Z: Expected {expected_z}, got {z_out}"
    
    dut._log.info("Testbench Cocotb selesai dan sukses!")
