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

entity db_baudrate_gen is
	Port (	clk : in STD_LOGIC;
			rd : out STD_LOGIC));
end dp_baudrate_gen;

architecture Behavioral of db_baudrate_gen is
	-- Local variables and functions
begin
	-- Actual behavior of Module
	process(clk) 
	begin
		-- It's supposed to count to a sixteenth of the baudrate to give an oversampling rate of 16. The UART will handle the logic of what to do with this frequency.
	end process;
end Behavioral;