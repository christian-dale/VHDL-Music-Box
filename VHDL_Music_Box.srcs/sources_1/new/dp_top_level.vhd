----------------------------------------------------------------------------------
-- Top design module: Digital Piano
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    generic(
        ADDR_WIDTH: integer:=10;
        DATA_WIDTH: integer:=8;
        MIDI_WIDTH: integer:=7
    );
    port ( 
        clk:        in std_logic;
        rst:        in std_logic;
        play:       in std_logic;
        Rx:         in std_logic;
        sqwv_out:   out std_logic
        );
end top_module;

architecture arch of top_module is
signal s_tick: std_logic; -- baud rate counter for UART receiver
signal uart_data: std_logic_vector(DATA_WIDTH-1 downto 0); -- ASCII code sent from UART_Rx
signal Rx_done: std_logic; -- UART_Rx signalling bit received
signal inc_A, clr_A: std_logic; -- CP sending instructions to address counter
signal write: std_logic; -- CP instructing RAM to write ASCII to address
signal ram_data: std_logic_vector(DATA_WIDTH-1 downto 0); -- data sendt from RAM
signal address: std_logic_vector(ADDR_WIDTH-1 downto 0); -- Address information sendt from counter to RAM
signal midi_data: std_logic_vector(MIDI_WIDTH-1 downto 0); -- Code converter sending to Sqwv generator
signal clear_FF: std_logic; -- CP sending clear to Midi Sqwv generator
signal sqwv_data: std_logic; -- Square wave signal sent to speaker

----------------------------------------------------------------------------------
begin

-- TO DO: Fill in UART and UART mod m counter modules (modules 1 and 2 below) once they have been designed

-- Instatiating Baud rate generator for the UART receiver
    mod_m_uart_unit: entity work.module1(arch)
        port map (  clk=>clk, rst=>rst, ... );

-- Instatiating UART receiver
    module2: entity work.module2(arch)
        port map (  clk=>clk, rst=>rst, ... );
					
-- Instatiate address counter
    address_counter_unit: entity work.module3(arch)
        port map (  clk=>clk, rst=>rst, ... );

-- other statements at the top level
... <= ...;
    
end arch;