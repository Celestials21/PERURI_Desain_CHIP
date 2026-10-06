library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_cordic is
end entity tb_cordic;

architecture sim of tb_cordic is
  signal clk       : std_logic := '0';
  signal x_in      : signed(15 downto 0) := to_signed(100, 16);
  signal y_in      : signed(15 downto 0) := to_signed(50, 16);
  signal z_in      : signed(15 downto 0) := (others => '0');
  signal atan_val  : signed(15 downto 0) := to_signed(45, 16); -- dummy atan
  
  signal x_out     : signed(15 downto 0);
  signal y_out     : signed(15 downto 0);
  signal z_out     : signed(15 downto 0);
begin
  -- Clock generation
  clk <= not clk after 10 ns;
  
  uut: entity work.cordic_stage
    generic map ( I => 0 )
    port map (
      clk      => clk,
      x_in     => x_in,
      y_in     => y_in,
      z_in     => z_in,
      atan_val => atan_val,
      x_out    => x_out,
      y_out    => y_out,
      z_out    => z_out
    );

  -- Stimulus
  stim_proc: process
  begin
    wait for 20 ns;
    -- Change inputs to observe output
    y_in <= to_signed(-30, 16);
    wait for 20 ns;
    assert false report "Simulation Finished" severity failure;
  end process;
end architecture sim;
