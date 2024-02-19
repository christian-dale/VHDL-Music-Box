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
			rd : in STD_LOGIC));
end dp_uart_rx;

architecture Behavioral of db_uart_rx is
	-- Local variables and functions
begin
	-- Actual behavior of Module
	process(rd) 
	begin
	end process;
end Behavioral;