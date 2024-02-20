-- top level of the e-piano

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity epiano is
   generic( 
      ADDR_WIDTH: integer:=10;
      DATA_WIDTH: integer:=8
   );
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           rxd : in  STD_LOGIC;
		   ldspkr : out  STD_LOGIC);
end epiano;

architecture struct_arch of epiano is
signal s_tick: std_logic;
signal uart_data: std_logic_vector(DATA_WIDTH-1 downto 0);
signal timer_done: std_logic;
signal rx_done_tick: std_logic;
signal mcnt_in: std_logic_vector(17 downto 0);
signal mcnt_tick: std_logic;
signal mute: std_logic;
signal enter_pressed : std_logic;
signal space_pressed : std_logic;

begin
	-- instantiate mod-m counter (baud rate generator for UART)
	mod_m_uart_unit: entity work.mod_m_uart(arch)
		port map(clk => clk, rst => rst, s_tick => s_tick);
		
	-- instantiate UART receiver
	uart_rx_unit: entity work.uart_rx(arch)
		port map(clk => clk, rst => rst, rxd => rxd, s_tick => s_tick,
					rx_done_tick => rx_done_tick, uart_data => uart_data);		
						
	-- instantiate code converter
	code_converter_unit: entity work.code_converter(arch)
		port map(uart_data => uart_data, enter_pressed => enter_pressed,
		space_pressed => space_pressed, mcnt_in => mcnt_in);		

	-- instantiate mod-m counter (T flip-flop)
	mod_m_t_ff_unit: entity work.mod_m_t_ff(arch)
		port map(clk => clk, rst => rst, mcnt_in => mcnt_in, mcnt_tick => mcnt_tick);		
		
	-- instantiate T flip-flop
	t_ff_en_unit: entity work.t_ff_en(arch)
		port map(clk => clk, rst => rst, mcnt_tick => mcnt_tick, 
					mute => mute, ldspkr => ldspkr);	
				
end struct_arch;

