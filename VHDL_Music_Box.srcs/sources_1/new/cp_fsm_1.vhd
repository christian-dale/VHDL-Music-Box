library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cp_fsm_1 is
    port (
        signal clk: in std_logic;
        signal JA1: inout std_logic;
        signal sw_0: in std_logic
    );
end cp_fsm_1;

architecture Behavioral of cp_fsm_1 is
begin
   mod_midi_sqwv: entity work.dp_midi_sqwv(Behavioral)
       port map(clk => clk, JA1 => JA1, sw_0 => sw_0, note => 90);
end Behavioral;
