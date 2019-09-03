-- fsm.vhd: Finite State Machine
-- Author: Katerina Fortova (xforto00)
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (START, PRINT_TRUE, PRINT_FALSE, WAIT_FALSE, PRINT_MESSAGE, FINISH, TEST1, TEST2, TEST3, TEST4, TEST5_X, TEST5_Y, TEST6_X, TEST6_Y, TEST7_X, TEST7_Y, TEST8_X, TEST8_Y, TEST9_X, TEST9_Y, TEST10_X, TEST10_Y, TEST11_X, TEST11_Y, TEST12_X, TEST12_Y);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when START =>
      next_state <= TEST1;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST1 =>
      next_state <= TEST1;
      if (KEY(1)='1') then
        next_state <= TEST2;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST2 =>
      next_state <= TEST2;
      if (KEY(3)='1') then
        next_state <= TEST3;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST3 =>
      next_state <= TEST3;
      if (KEY(8)='1') then
        next_state <= TEST4;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    -- 1. kod - kod1 = 13814699360
    -- 2. kod - kod2 = 13827733083

    when TEST4 =>
      next_state <= TEST4;
       if (KEY(1)='1') then
        next_state <= TEST5_X;
      elsif (KEY(2) = '1') then
        next_state <= TEST5_Y;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST5_X =>
      next_state <= TEST5_X;
      if (KEY(4)='1') then
        next_state <= TEST6_X;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST5_Y =>
      next_state <= TEST5_Y;
      if (KEY(7)='1') then
        next_state <= TEST6_Y;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST6_X =>
      next_state <= TEST6_X;
      if (KEY(6)='1') then
        next_state <= TEST7_X;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST6_Y =>
      next_state <= TEST6_Y;
      if (KEY(7)='1') then
        next_state <= TEST7_Y;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST7_X =>
      next_state <= TEST7_X;
      if (KEY(9)='1') then
        next_state <= TEST8_X;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST7_Y =>
      next_state <= TEST7_Y;
      if (KEY(3)='1') then
        next_state <= TEST8_Y;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST8_X =>
      next_state <= TEST8_X;
      if (KEY(9)='1') then
        next_state <= TEST9_X;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST8_Y =>
      next_state <= TEST8_Y;
      if (KEY(3)='1') then
        next_state <= TEST9_Y;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;


    when TEST9_X =>
        next_state <= TEST9_X;
        if (KEY(3)='1') then
          next_state <= TEST10_X;
        elsif (KEY(15) = '1') then
          next_state <= PRINT_FALSE;
        elsif (KEY(14 downto 0) /= "000000000000000") then
          next_state <= WAIT_FALSE;
        end if;

    when TEST9_Y =>
        next_state <= TEST9_Y;
        if (KEY(0)='1') then
          next_state <= TEST10_Y;
        elsif (KEY(15) = '1') then
          next_state <= PRINT_FALSE;
        elsif (KEY(14 downto 0) /= "000000000000000") then
          next_state <= WAIT_FALSE;
        end if;


    when TEST10_X =>
      next_state <= TEST10_X;
      if (KEY(6)='1') then
        next_state <= TEST11_X;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST10_Y =>
      next_state <= TEST10_Y;
      if (KEY(8)='1') then
        next_state <= TEST11_Y;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST11_X =>
      next_state <= TEST11_X;
      if (KEY(0)='1') then
        next_state <= TEST12_X;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST11_Y =>
      next_state <= TEST11_Y;
      if (KEY(3)='1') then
        next_state <= TEST12_Y;
      elsif (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
        next_state <= WAIT_FALSE;
      end if;

    when TEST12_X =>
      next_state <= TEST12_X;
      if (KEY(15) = '1') then
        next_state <= PRINT_TRUE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
		    next_state <= WAIT_FALSE;
      end if;

    when TEST12_Y =>
      next_state <= TEST12_X;
      if (KEY(15) = '1') then
        next_state <= PRINT_TRUE;
      elsif (KEY(14 downto 0) /= "000000000000000") then
		    next_state <= WAIT_FALSE;
      end if;

-- - - - - - - - - - - - - - - - - - - - - - -
    when WAIT_FALSE =>
      next_state <= WAIT_FALSE;
      if (KEY(15) = '1') then
        next_state <= PRINT_FALSE;
         end if;

    when PRINT_TRUE =>
      next_state <= PRINT_TRUE;
      if (CNT_OF = '1') then
        next_state <= FINISH;
      end if;

    when PRINT_FALSE =>
      next_state <= PRINT_FALSE;
      if (CNT_OF = '1') then
        next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
    when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST1;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= START;
    end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
    when PRINT_TRUE =>
      FSM_CNT_CE     <= '1';
      FSM_MX_MEM     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
-- - - - - - - - - - - - - - - - - - - - - - -
    when PRINT_FALSE =>
      FSM_CNT_CE     <= '1';
      FSM_MX_MEM     <= '0';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';

    when FINISH =>
    if (KEY(15) = '1') then
      FSM_LCD_CLR    <= '1';
    end if;
    -- - - - - - - - - - - - - - - - - - - - - - -
    when others =>
      if (KEY(14 downto 0) /= "000000000000000") then
       FSM_LCD_WR     <= '1';
     end if;

      if (KEY(15) = '1') then
       FSM_LCD_CLR    <= '1';
      end if;

    end case;
 end process output_logic;

 end architecture behavioral;
