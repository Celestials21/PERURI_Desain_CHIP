library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity feature_accumulator is
port (
clk : in std_logic;
reset : in std_logic;
mag_in : in signed(15 downto 0); -- Magnitudo dari CORDIC
sample_valid : in std_logic;
feat_power : out signed(7 downto 0) -- Fitur daya rata-rata (INT8)
);
end entity;

architecture rtl of feature_accumulator is
signal sum_acc : signed(23 downto 0) := (others => '0');
signal count : unsigned(3 downto 0) := (others => '0');
begin
process(clk) begin
if rising_edge(clk) then
if reset = '1' then
sum_acc <= (others => '0');
count <= (others => '0');
elsif sample_valid = '1' then
sum_acc <= sum_acc + mag_in;
count <= count + 1;

-- Setiap 16 sampel (1 segmen), hitung rata-rata via shift right 4
if count = 15 then
feat_power <= resize(shift_right(sum_acc, 4), 8);
sum_acc <= (others => '0');
end if;
end if;
end if;
end process;
end architecture;
