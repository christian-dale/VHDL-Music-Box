-- T_FF (toggle flip-flop) adapted from listing 4.4 of P. Chu's book

library ieee;
use ieee.std_logic_1164.all;

entity t_ff_en is
   port(
        clk, rst: in std_logic;
        zero_tick: in std_logic;
		mute: in std_logic;
        sqwave: out std_logic
      );
end t_ff_en;

architecture arch of t_ff_en is
   signal r_reg, r_nxt: std_logic;
begin

   -- T FF
   process(clk,rst)
   begin
      if (rst='1') then
         r_reg <='0';
      elsif rising_edge(clk) then
         r_reg <= r_nxt;
      end if;
   end process;
	
   -- next-state logic
	process(r_reg, mute, zero_tick)
   begin
	if (mute = '1') then
		r_nxt <= '0';
	elsif (zero_tick = '1') then
		r_nxt <= not(r_reg);
	else
		r_nxt <= r_reg;
	end if;
	end process;

   -- output logic
   sqwave <= r_reg;
	
end arch;
