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

entity dp_code_converter is
    Port ( ascii_in : in STD_LOGIC_VECTOR (7 downto 0);
           midi_out : out INTEGER(0 to 127));
end dp_code_converter;

architecture Behavioral of dp_code_converter is
	function ASCII_to_MIDI(ascii_char : character) return INTEGER is
		constant Base_Note : INTEGER := 60; -- Corresponds to middle C
		constant Octave_Step : INTEGER := 12; -- Difference between octaves
		
		variable midi_code : INTEGER;
		
	begin
		-- Assign notes to the key presses
		case ascii_char is -- Letters chosen are the home row from left to right
			when 'a' | 'A' midi_code := Base_Note;		--C
			when 's' | 'S' midi_code := Base_Note +2;	--D
			when 'd' | 'D' midi_code := Base_Note +4;	--E
			when 'f' | 'F' midi_code := Base_Note +5;	--F
			when 'g' | 'G' midi_code := Base_Note +7;	--G
			when 'h' | 'H' midi_code := Base_Note +9;	--A
			when 'j' | 'J' midi_code := Base_Note +11;	--B
			when others midi_code := -1; -- Shouldn't happen, but good to have a case for the unexpected.
		end case;
		
		-- Modulate if the letter is capital
		if ascii_char in 'A' | 'S' | 'D' | 'F' | 'G' | 'H' | 'J' then
			midi_code := midi_code + Octave_Step; -- Transposes to the octave above
		end if;
		
		return midi_code;
	end ASCII_to_MIDI;
	
	signal ascii_char : character;

begin
	-- Turn the incoming vector into a character
	ascii_char <= character'val(to_unsigned(ascii_in));
	
	midi_out <= ASCII_to_MIDI(ascii_char);
end Behavioral;
