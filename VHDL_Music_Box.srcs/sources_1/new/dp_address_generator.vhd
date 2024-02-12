----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2024 12:43:49
-- Design Name: 
-- Module Name: dp_address_generator - Behavioral
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

entity dp_address_generator is
    Port ( inc : in STD_LOGIC; -- increment
           rst : in STD_LOGIC; -- reset
		   clk : in STD_LOGIC; -- clock
           address_out : out STD_LOGIC_VECTOR (9 downto 0));
end dp_address_generator;

architecture Behavioral of dp_address_generator is
	signal counter : INTEGER range 0 to 1023 := 0;
begin
	process(clk, rst)
	begin
		if rst = '1' then
			counter <= 0;
		elsif rising_edge(clk) then
			if inc = '1' then
				counter <= counter+1;
			end if;
		end if;
	end process;
	
	address_out <= STD_LOGIC_VECTOR(to_unsigned(counter, address_out'length));
	
end Behavioral;
