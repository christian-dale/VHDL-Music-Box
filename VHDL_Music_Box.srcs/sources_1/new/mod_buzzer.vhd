library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod_buzzer is
    generic (
        CLK_HZ: integer := 100 * 1000000;
        A_2: integer := 440
    );

    port (
        clk: in std_logic;
        JA1: inout std_logic
    );
end mod_buzzer;

architecture Behavioral of mod_buzzer is
begin
    process (clk)
        variable i: integer := 0;
    begin
        if rising_edge(clk) then
            if i = (CLK_HZ / A_2) / 2 then
                i := 0;
                JA1 <= not JA1;
            else
                i := i + 1;
            end if;
        end if;
    end process;
end Behavioral;
