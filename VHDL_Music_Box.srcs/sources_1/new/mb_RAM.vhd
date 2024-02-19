----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2024 10:43:25
-- Design Name: 
-- Module Name: dp_ram - Behavioral
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

entity dp_ram is
    Port ( ram_ascii_in : in STD_LOGIC_VECTOR (7 downto 0);
           wr : in STD_LOGIC; -- Whether to write to RAM or not
           address : in STD_LOGIC_VECTOR (9 downto 0); -- Where are we?
		   clk: in STD_LOGIC;
		   ram_ascii_out : out STD_LOGIC_VECTOR (7 downto 0));
end dp_ram;

architecture Behavioral of dp_ram is
	type ram_type is array (0 to 1023) of STD_LOGIC_VECTOR(7 downto 0); -- 1kb array of 8bit ascii 
	signal RAM: ram_type := (others => "00000000"); -- Set all elements to zero
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if wr = '1' then
				RAM(to_integer(unsigned(address))) <= ram_ascii_in;
			end if;
			ram_ascii_out <= RAM(conv_integer(address));
		end if;
	end process;
end Behavioral;
