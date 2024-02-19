library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cp_fsm_1 is
    port (
        clk: in std_logic;
        JA1: inout std_logic;
        RsRx: in std_logic; -- Uart receive data bit
        led_0: inout std_logic
    );
end cp_fsm_1;

architecture Behavioral of cp_fsm_1 is
begin
   mod_midi_sqwv: entity work.dp_midi_sqwv(Behavioral)
       port map(clk => clk, JA1 => JA1, note => 90);
       
   mod_uart_rx: entity work.dp_uart_rx(Behavioral)
       port map(clk => clk, RsRx => RsRx, led_0 => led_0);
end Behavioral;
