-- Modulus counter for the UART baud rate generator adapted from P. Chu's Listing 4.11

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_m_uart is
   generic(
      N: integer := 9;     -- number of bits
      M: integer := 326     -- mod-M for 19.200 bps @ 100 MHz
  );
   port(
      clk, rst: in std_logic;
      s_tick: out std_logic;
      q: out std_logic_vector(N-1 downto 0)
   );
end mod_m_uart;

architecture arch of mod_m_uart is
   signal r_reg: unsigned(N-1 downto 0);
   signal r_nxt: unsigned(N-1 downto 0);
begin
   -- register
   process(clk,rst)
   begin
      if (rst='1') then
         r_reg <= (others=>'0');
      elsif rising_edge(clk) then
         r_reg <= r_nxt;
      end if;
   end process;
   -- next-state logic
   r_nxt <= (others=>'0') when r_reg=(M-1) else
             r_reg + 1;
   -- output logic
   q <= std_logic_vector(r_reg);
   s_tick <= '1' when r_reg=(M-1) else '0';
end arch;