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
	signal data_index : INTEGER(0 to 8) := 0;
	signal counter : INTEGER(0 to 15) := 0;
	signal state : stateType := idle_st;
begin
	-- Actual behavior of Module
	process(rd) 
	begin
		if rising_edge(rd) then -- It will only do things when this counter ticks
			case state is -- Checks the current state
				when idle_st =>
					if Serial_in = '1' then -- Breaks without doing anything
						counter := 0; -- Makes sure the counter is reset, if something goes wrong in transmission
					elsif Serial_in = '0' then
						if counter != '7' then
							counter := counter +1; -- Counts to the middle of the bit
							
						elsif counter = '7' then -- When at the middle of the bit,
							counter := '0'; -- we reset the counter,
							state := read_st; -- and enter the actual read state.
						end if;
					end if;
					
				when read_st =>
					if data_index = 8 then -- If we're outside the data vector
						stateType := end_st; -- we enter the end state
						data_index := 0; -- and reset the index for the next round.
					else then
						if counter = 15 then -- If we're in the middle of the data bit,
							data(data_index) := Serial_in; -- we read the data bit to the vector,
							data_index := data_index +1; -- increment the index,
							counter := 0; -- and reset the counter.
						else then
						counter := counter +1; -- If we're not in the middle of the bit, we just count up one.
						end if;
					end if;
					
				when end_st =>
					if we 
					
			end case;
		end if;
	end process;
end Behavioral;

-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;

-- entity dp_uart_rx is
--     port (
--         clk: in std_logic;
--         RsRx: in std_logic;
--         led_0: out std_logic
--     );
-- end dp_uart_rx;

-- architecture Behavioral of dp_uart_rx is
-- begin
--     process (clk)
--         variable i: natural := 0;
--         variable start_bit_received: boolean := false;
--     begin
--         if rising_edge(clk) then
--             if i = 100_000_000 / 9600 then
--                 --if falling_edge(RsRx) then
--                     --start_bit_received := true;
--                 --end if;
                
--                 if start_bit_received = true then
--                     -- led_0 <= '1';
--                 end if;
                
--                 i := 0;
--             else
--                 i := i + 1;
--             end if;
--         end if;
--     end process;
-- end Behavioral;
