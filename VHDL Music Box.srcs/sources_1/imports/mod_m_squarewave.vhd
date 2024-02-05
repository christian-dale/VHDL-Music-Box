-- Modulus counter for the T FF adapted from P. Chu's Listing 4.11
-- Number of bits required is given by:
-- 1) Lowest frequency is octave 4 Do (q): 261,626 Hz
-- 2) Pulses to toggle the output FF: ____|____|____|____|__
--                                         ____      ____   
--    (every (1 / (2 x 261,626))      ____|    |____|    |___
-- 3) no. of clock pulses in-between two consecutive pulses is
--    (100x10^6 / (2 x 261,626)) = 191.112,504
-- 4) No. of bits: log2(191.112,504), i.e. 18 bits
-- 5) All other frequencies are higher, so 18 bits is always enough

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_m_squarewave is
   generic(
      N: integer := 18     -- number of bits
--    M: integer := (varies according to the musical note to play)
  );
   port(
        clock, reset: in std_logic; -- Clock and reset
		mcnt_in: in std_logic_vector(N-1 downto 0);
        zero_tick: out std_logic;
        q: out std_logic_vector(N-1 downto 0)
       );
end mod_m_squarewave;

architecture arch of mod_m_squarewave is
   signal r_reg: unsigned(N - 1 downto 0);
   signal r_next: unsigned(N - 1 downto 0);
begin
   -- register
   process(clock, reset)
   begin
      if (reset = '1') then
         r_reg <= (others => '0');
      elsif rising_edge(clock) then
         r_reg <= r_next;
      end if;
   end process;
   
   -- next-state logic
   r_next <= unsigned(mcnt_in) when r_reg=0 else
             r_reg - 1;
   
   -- output logic
   q <= std_logic_vector(r_reg);
   
   zero_tick <= '1' when r_reg = 0 else '0';
end arch;