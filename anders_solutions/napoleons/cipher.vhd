library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cipher is
    Port ( ascii_r : in STD_LOGIC_VECTOR (7 downto 0);
           decrypt_flag : in std_logic;
           cphr_out : out STD_LOGIC_VECTOR (7 downto 0));
end cipher;

architecture arch of cipher is
signal sdin:  unsigned (7 downto 0);
signal sdout: unsigned (7 downto 0);

begin
   sdin <= unsigned(ascii_r);    

   sdout <= -- case of space:
         x"20" when (sdin=x"20") else
         x"0D" when (sdin=x"0D") else
         
         (sdin - x"2") when (decrypt_flag = '1') else
         (sdin + x"2") when (decrypt_flag = '0');
         
    cphr_out <= std_logic_vector(sdout);
    
end arch;
