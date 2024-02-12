library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

-- Midi note / key number reference:
-- https://computermusicresource.com/midikeys.html

entity dp_midi_sqwv is
    generic (
        CLK_HZ: integer := 100 * 1000000;
        A_2: integer := 440
    );

    port (
        signal clk: in std_logic;
        signal JA1: inout std_logic;
        signal sw_0: in std_logic
    );
end dp_midi_sqwv;

architecture Behavioral of dp_midi_sqwv is
    -- Formula (midi note to frequency): f = 2^((n - 69) / 12) * 440
    function midi_to_hz(note_number: integer) return integer is
        constant a4_hz: integer := 440;
    begin
        return 2 ** ((note_number - 69) / 12) * a4_hz;
    end function midi_to_hz;
    
    function hz_to_clk(hz: integer) return integer is
    begin
        return (CLK_HZ / hz) / 2;
    end function hz_to_clk;
begin
    process (clk)
        variable i: integer := 0;
        variable note: integer := 90;
        variable toggle: boolean := false;
    begin
        if rising_edge(clk) then
            -- Halve the number here to get half a period.
            if i = hz_to_clk(midi_to_hz(note)) then
                i := 0;
                JA1 <= not JA1;
            else
                i := i + 1;
            end if;
            
            -- Check switch
            if sw_0 = '1' and toggle = false then
                toggle := true;
                note := 69;
            end if;
        end if;
    end process;
end Behavioral;
