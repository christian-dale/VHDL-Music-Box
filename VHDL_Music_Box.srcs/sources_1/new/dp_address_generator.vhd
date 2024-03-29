library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dp_address_generator is
    Port ( inc_A : in STD_LOGIC; -- increment
           clr_A : in STD_LOGIC; -- reset
		   clk : in STD_LOGIC; -- clock
           address : out STD_LOGIC_VECTOR (9 downto 0));
end dp_address_generator;

architecture Behavioral of dp_address_generator is
	signal counter : INTEGER range 0 to 1023 := 0;
begin
	process(clk, clr_A)
	begin
		if clr_A = '1' then
			counter <= 0;
		elsif rising_edge(clk) then
			if inc_A = '1' then
				counter <= counter+1;
			end if;
		end if;
	end process;
	
	address <= STD_LOGIC_VECTOR(to_unsigned(counter, address'length));
	
end Behavioral;
