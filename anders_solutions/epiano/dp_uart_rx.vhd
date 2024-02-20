-- UART receiver using P. Chu's Listing 7.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
   generic(
      DBIT: integer:=8;     -- # data bits
      SB_TICK: integer:=16  -- # ticks for stop bits
   );
   port(
      clk, rst: in std_logic;
      rxd: in std_logic;
      s_tick: in std_logic;
      rx_done_tick: out std_logic;
      uart_data: out std_logic_vector(7 downto 0)
   );
end uart_rx ;

architecture arch of uart_rx is
   type state_type is (idle, start, data, stop);
   signal st_reg, st_nxt: state_type;
   signal s_reg, s_nxt: unsigned(3 downto 0);
   signal n_reg, n_nxt: unsigned(2 downto 0);
   signal b_reg, b_nxt: std_logic_vector(7 downto 0);
begin
   -- FSMD state & data registers
   process(clk,rst)
   begin
      if rst='1' then
         st_reg <= idle;
         s_reg <= (others=>'0');
         n_reg <= (others=>'0');
         b_reg <= (others=>'0');
      elsif rising_edge(clk) then
         st_reg <= st_nxt;
         s_reg <= s_nxt;
         n_reg <= n_nxt;
         b_reg <= b_nxt;
      end if;
   end process;
   -- next-state logic & data path functional units/routing
   process(st_reg,s_reg,n_reg,b_reg,s_tick,rxd)
   begin
      st_nxt <= st_reg;
      s_nxt <= s_reg;
      n_nxt <= n_reg;
      b_nxt <= b_reg;
      rx_done_tick <='0';
      case st_reg is
         when idle =>
            if rxd='0' then
               st_nxt <= start;
               s_nxt <= (others=>'0');
            end if;
         when start =>
            if (s_tick = '1') then
               if s_reg=7 then
                  st_nxt <= data;
                  s_nxt <= (others=>'0');
                  n_nxt <= (others=>'0');
               else
                  s_nxt <= s_reg + 1;
               end if;
            end if;
         when data =>
            if (s_tick = '1') then
               if s_reg=15 then
                  s_nxt <= (others=>'0');
                  b_nxt <= rxd & b_reg(7 downto 1) ;
                  if n_reg=(DBIT-1) then
                     st_nxt <= stop ;
                  else
                     n_nxt <= n_reg + 1;
                  end if;
               else
                  s_nxt <= s_reg + 1;
               end if;
            end if;
         when stop =>
            if (s_tick = '1') then
               if s_reg=(SB_TICK-1) then
                  st_nxt <= idle;
                  rx_done_tick <='1';
               else
                  s_nxt <= s_reg + 1;
               end if;
            end if;
      end case;
   end process;
   uart_data <= b_reg;
end arch;