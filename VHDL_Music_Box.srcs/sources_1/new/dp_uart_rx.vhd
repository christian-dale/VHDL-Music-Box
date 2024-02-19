----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2024 16:24:00
-- Design Name: 
-- Module Name: dp_code_converter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity db_uart_rx is
	Port (	Serial_in : in STD_LOGIC;
			ascii_out : out STD_LOGIC_VECTOR (7 downto 0);
			rx_done : out STD_LOGIC;
			rd : in STD_LOGIC));
end dp_uart_rx;

architecture Behavioral of db_uart_rx is
	-- Local variables and functions
	type stateType is (idle_st, read_st, end_st);
	signal data : STD_LOGIC_VECTOR(7 downto 0);
	signal counter : INTEGER(0 to 15);
	signal state : stateType := idle_st;
begin
	-- Actual behavior of Module
	process(rd) 
	begin
		if rising_edge(rd) then -- It will only do things when this counter ticks
			case state is -- Checks the current state
				when idle_st =>
					if data = '1' then
					elsif data 
				when read_st =>
				when end_st =>
			end case;
		end if;
	end process;
end Behavioral;