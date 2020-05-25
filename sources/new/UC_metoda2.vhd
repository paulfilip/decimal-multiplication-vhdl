library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC_metoda2 is
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    Start: IN std_logic;
    LoadA: OUT std_logic;
    RstA: OUT std_logic;
    LoadQ: OUT std_logic;
    RstQ: OUT std_logic;
    shrAQ: OUT std_logic;
    LoadX: OUT std_logic_vector(8 downto 0);
    RstX: OUT std_logic_vector(8 downto 0);
    MuxInit: OUT std_logic;
    Term: OUT std_logic);
end UC_metoda2;

architecture Behavioral of UC_metoda2 is
type stare is (idle, init, init2X, init3X, init4X, init5X, init6X, init7X, init8X, init9X, adun, shiftez, testC, stop);
signal state:stare:=idle;
signal STEP_CNT: std_logic_vector(2 downto 0):="000";
 
begin

proces_stare: process(Clk)
begin
    if(Rst = '1') then
        state <= idle;
    else
        if (Clk = '1' and Clk'event) then
            case state is
                when idle =>
                            if(Start = '1') then
                                state <= init;
                            else
                                state <= idle;
                            end if;
                            STEP_CNT <= "100";
                when init =>
                            state <= init2X;
                when init2X => 
                            state <= init3X;
                when init3X => 
                            state <= init4X;
                when init4X => 
                            state <= init5X;
                when init5X => 
                            state <= init6X;
                when init6X => 
                            state <= init7X;
                when init7X => 
                            state <= init8X;
                when init8X => 
                            state <= init9X;
                when init9X =>
                            state <= adun;
                when adun =>
                            state <= shiftez;
                when shiftez =>
                            state <= testC;
                            STEP_CNT <= STEP_CNT - 1;
                when testC =>
                            if(STEP_CNT > 0) then
                                state <= adun;
                            else
                                state <= stop;
                            end if;
                when others =>
                            state <= stop;
            end case;
        end if;
    end if;
end process;

proces_iesiri: process(state)
begin
    case state is
        when idle =>  
                LoadA <= '0';
                RstA <= '1';
                LoadQ <= '0';
                RstQ <= '1';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000001";
                RstX <= "111111110";
                Term <= '0';
                
         when init =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '1';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';
                
         when init2X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000000010";
                RstX <= "000000000";
                Term <= '0';
         
         when init3X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000000100";
                RstX <= "000000000";
                Term <= '0';
                
         when init4X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000001000";
                RstX <= "000000000";
                Term <= '0';

         when init5X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000010000";
                RstX <= "000000000";
                Term <= '0';

         when init6X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "000100000";
                RstX <= "000000000";
                Term <= '0';

         when init7X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "001000000";
                RstX <= "000000000";
                Term <= '0';

         when init8X =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "010000000";
                RstX <= "000000000";
                Term <= '0';

         when init9X =>
                LoadA <= '0';
                RstA <= '1';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '1';
                LoadX <= "100000000";
                RstX <= "000000000";
                Term <= '0';
         
         when adun =>
                LoadA <= '1';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';

         when shiftez =>
                LoadA <= '0';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '1';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';

         when testC =>
                LoadA <= '0';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '0';

         when stop =>
                LoadA <= '0';
                RstA <= '0';
                LoadQ <= '0';
                RstQ <= '0';
                shrAQ <= '0';
                MuxInit <= '0';
                LoadX <= "000000000";
                RstX <= "000000000";
                Term <= '1';      
    end case;
end process;
end Behavioral;
