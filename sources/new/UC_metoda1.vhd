library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity UC_metoda1 is
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    Start: IN std_logic;
    Q0: IN std_logic_vector(3 downto 0);
    LoadB: OUT std_logic;
    RstA: OUT std_logic;
    RstB: OUT std_logic;
    RstQ: OUT std_logic;
    LoadA: OUT std_logic;
    LoadQ: OUT std_logic;
    shrAQ: OUT std_logic;
    Term: OUT std_logic);
end UC_metoda1;

architecture Behavioral of UC_metoda1 is

type stare is (idle, init,initCifra, testCifra, operatiiProdPartial, shiftare, testC, stop);
signal state: stare:=idle;
signal DIGIT_CNT: std_logic_vector(3 downto 0):="0000";
signal STEP_CNT: std_logic_vector(2 downto 0):="000";

begin

proces_stare: process(clk)
begin
    if(Rst = '1') then
        state <= idle;
    elsif(clk = '1' and clk'event) then
        case state is
            when idle => if(Start = '1') then
                            state <= init;
                         else
                            state <= idle;
                         end if; 
                         STEP_CNT <= "100";
            when init => state <= initCifra;
            when initCifra =>  DIGIT_CNT <= Q0; 
                                state <= testCifra;
            when testCifra => if(DIGIT_CNT > 0) then
                                state <= operatiiProdPartial;
                                DIGIT_CNT <= DIGIT_CNT - 1;
                              else
                                state <= shiftare;
                                STEP_CNT <= STEP_CNT - 1;
                                DIGIT_CNT <= Q0;
                              end if;
            when operatiiProdPartial => state <= testCifra;
            when shiftare => state <= testC;
            when testC => if(STEP_CNT > 0) then
                              state <= initCifra;
                          else
                              state <= stop;
                          end if;
            when stop => state <= stop;
        end case;
    end if;
end process;

proces_iesiri: process(state)
    begin
        case state is
            when idle => LoadA <= '0';
                         RstA <= '1';
                         RstB <= '1';
                         RstQ <= '1';
                         LoadB <= '0';
                         shrAQ <= '0';
                         LoadQ <= '0';
                         Term <= '0';
                         
             when init => LoadA <= '1';
                         RstA <= '0';
                         RstB <= '0';
                         RstQ <= '0';
                         LoadB <= '1';
                         shrAQ <= '0';
                         LoadQ <= '1';
                         Term <= '0';
             when initCifra => LoadA <= '0';
                                RstA <= '0';
                                RstB <= '0';
                                RstQ <= '0';
                                LoadB <= '0';
                                shrAQ <= '0';
                                LoadQ <= '0';
                                Term <= '0';
                                           
             when testCifra => LoadA <= '0';
                                RstA <= '0';
                                RstB <= '0';
                                RstQ <= '0';
                                LoadB <= '0';
                                shrAQ <= '0';
                                LoadQ <= '0';
                                Term <= '0';
             when operatiiProdPartial =>
                                        LoadA <= '1';
                                        RstA <= '0';
                                        RstB <= '0';
                                        RstQ <= '0';
                                        LoadB <= '0';
                                        shrAQ <= '0';
                                        LoadQ <= '0';
                                        Term <= '0';
             when shiftare =>   LoadA <= '0';
                                RstA <= '0';
                                RstB <= '0';
                                RstQ <= '0';
                                LoadB <= '0';
                                shrAQ <= '1';
                                LoadQ <= '0';
                                Term <= '0';
             
             when testC =>
                            LoadA <= '0';
                            RstA <= '0';
                            RstB <= '0';
                            RstQ <= '0';
                            LoadB <= '0';
                            shrAQ <= '0';
                            LoadQ <= '0';
                            Term <= '0';
             when stop =>
                            LoadA <= '0';
                            RstA <= '0';
                            RstB <= '0';
                            RstQ <= '0';
                            LoadB <= '0';
                            shrAQ <= '0';
                            LoadQ <= '0';
                            Term <= '1';
        end case;
    end process;
end Behavioral;
