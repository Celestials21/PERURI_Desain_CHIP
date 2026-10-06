library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cordic_stage is
  generic ( I : integer := 0 ); -- Indeks pergeseran bit (0-15)
  port (
    clk       : in  std_logic;
    x_in      : in  signed(15 downto 0);
    y_in      : in  signed(15 downto 0);
    z_in      : in  signed(15 downto 0);
    atan_val  : in  signed(15 downto 0); -- Nilai sudut atan(2^-I) dari LUT
    x_out     : out signed(15 downto 0);
    y_out     : out signed(15 downto 0);
    z_out     : out signed(15 downto 0)
  );
end entity;

architecture rtl of cordic_stage is
begin
  process(clk) begin
    if rising_edge(clk) then
      -- Mengecek arah rotasi berdasarkan tanda nilai y
      if y_in >= 0 then
        x_out <= x_in + shift_right(y_in, I);
        y_out <= y_in - shift_right(x_in, I);
        z_out <= z_in + atan_val;
      else
        x_out <= x_in - shift_right(y_in, I);
        y_out <= y_in + shift_right(x_in, I);
        z_out <= z_in - atan_val;
      end if;
    end if;
  end process;
end architecture;
