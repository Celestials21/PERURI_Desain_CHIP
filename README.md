# NiraGuard-8
Akselerator AI INT8 Berbasis Ekstraksi CORDIC untuk Pengamanan Komunikasi Nirkabel Hemat Daya

Repository ini berisi kode RTL (VHDL) dan testbench untuk sistem NiraGuard-8 yang menargetkan board Intel FPGA DE10-Nano (Cyclone V).

## Isi File:
- `src/cordic_stage.vhd`: Tahapan komputasi CORDIC tanpa pengali (add/shift) untuk pengukuran fasa & amplitudo.
- `src/pe.vhd`: Unit Processing Element (PE) untuk Systolic Array 4x4, mendukung INT8 akumulasi MAC.
- `src/feature_accumulator.vhd`: Pengekstrak ciri fisik (feature extraction) yang merangkum data sinyal CORDIC.
- `tb/tb_cordic.vhd`: Testbench sederhana untuk modul `cordic_stage.vhd`.

## Mengenai Bitstream (.sof / .rbf)
Karena Intel Quartus Prime diperlukan untuk mensintesis dan menghasilkan file bitstream (`.sof` atau `.rbf`) pada perangkat FPGA, kami tidak dapat menyertakan bitstream langsung di repositori ini. 
Silakan buat project di Intel Quartus Prime, impor file `.vhd` di direktori `src/`, assign ke device `Cyclone V (DE10-Nano)`, lalu jalankan proses **Kompilasi** (Compile Design) untuk mendapatkan bitstream akhir Anda.
