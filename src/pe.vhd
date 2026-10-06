library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pe is
  port (
    clk   : in  std_logic;
    clr   : in  std_logic; -- Sinyal reset akumulator
    a_in  : in  signed(7 downto 0); -- Aktivasi INT8 (dari kiri)
    b_in  : in  signed(7 downto 0); -- Bobot AI INT8 (dari atas)
    a_out : out signed(7 downto 0); -- Meneruskan aktivasi ke kanan
    b_out : out signed(7 downto 0); -- Meneruskan bobot ke bawah
    c_out : out signed(31 downto 0) -- Hasil akumulasi 32-bit
  );
end entity;

architecture rtl of pe is
  signal acc : signed(31 downto 0) := (others => '0');
begin
  process(clk) begin
    if rising_edge(clk) then
      if clr = '1' then
        acc <= (others => '0');
      else
        -- Akumulasi hasil perkalian INT8 -> INT32
        acc <= acc + (a_in * b_in);
      end if;
      a_out <= a_in; -- Meneruskan data ke PE kanan
      b_out <= b_in; -- Meneruskan data ke PE bawah
    end if;
  end process;
  c_out <= acc;
end architecture;
