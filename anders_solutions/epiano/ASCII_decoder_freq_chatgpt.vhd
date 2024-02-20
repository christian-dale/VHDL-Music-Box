library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity code_converter is
    Port ( uart_data : in STD_LOGIC_VECTOR(7 downto 0);
           mcnt_in : out STD_LOGIC_VECTOR(17 downto 0);
           enter_pressed, space_pressed : out std_logic);
end code_converter;

architecture arch of code_converter is
begin
    process(uart_data)
    begin
        case uart_data is
		
			-- Formula for mcnt_tick: x = (10^8)/(2*frequency)
			-- Space in hex: x"20"
			-- Enter in hex: x"0D"
			when x"20" =>                           -- kb: Space, start signal 
                mcnt_in <= "000000000000000000";    -- Set dummy modulo counter initial value
                space_pressed <= '1';           
			
			when x"0D" =>                           -- kb: Enter, stop signal 
                mcnt_in <= "000000000000000000";    -- Set dummy modulo counter initial value 
                enter_pressed <= '1';          
			
			
			-- Cases for q-u, octave 4:
			
            when x"71" =>                           -- kb: q note: C4 freq: 261.63 
                mcnt_in <= "101110101010000101";    -- Set modulo counter initial value for 'C'
            when x"77" =>                           -- kb: w note: D4 freq: 293.66
                mcnt_in <= "101001100100011001";
            when x"65" =>                           -- kb: e note: E4 freq: 329.63
                mcnt_in <= "100101000010000101";
            when x"72" =>                           -- kb: r note: F4 freq: 349.23
                mcnt_in <= "100010111101000100";
			when x"74" =>                           -- kb: t note: G4 freq: 392
                mcnt_in <= "011111001000111111";
			when x"79" =>                           -- kb: y note: A4 freq: 440
                mcnt_in <= "011011101111100100";
            when x"75" =>                           -- kb: u note: B4 freq: 493.88
                mcnt_in <= "011000101101110111";

            -- Cases for a-j, octave 5:
			
            when x"61" =>                           -- kb: a note: C5 freq: 523.25
                mcnt_in <= "010111010101000101";
            when x"73" =>                           -- kb: s note: D5 freq: 587.33
                mcnt_in <= "010100110010001011";
			when x"64" =>                           -- kb: d note: E5 freq: 659.26
                mcnt_in <= "010010100001000011";
            when x"66" =>                           -- kb: f note: F5 freq: 698.46
                mcnt_in <= "010001011110100010";
            when x"67" =>                           -- kb: g note: G5 freq: 783.99
                mcnt_in <= "001111100100100000";
			when x"68" =>                           -- kb: h note: A5 freq: 880
                mcnt_in <= "001101110111110010";
            when x"6A" =>                           -- kb: j note: B5 freq: 987.77
                mcnt_in <= "001100010110111011";
            
            -- Default case for other characters
            when others =>
                mcnt_in <= "000000000000000000"; -- Default frequency value for other characters
				
        end case;
    end process;
end arch;
