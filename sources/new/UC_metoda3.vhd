library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC_metoda3 is
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    Start: IN std_logic;
    LoadA: OUT std_logic;
    RstA: OUT std_logic;
    LoadQ: OUT std_logic;
    RstQ: OUT std_logic;
    LoadB: OUT std_logic;
    RstB: OUT std_logic;
    muxB: OUT std_logic;
    shrAQ: OUT std_logic;
    shiftRightAZ: OUT std_logic;
    CET1: OUT std_logic;
    RstT1: OUT std_logic;
    CET2: OUT std_logic;
    RstT2: OUT std_logic;
    control: OUT std_logic;
    Term: OUT std_logic );
end UC_metoda3;

architecture Behavioral of UC_metoda3 is

type stare is (idle, init, multiplyDigits, testRotate, shiftAQ, testC, stop);
signal state:stare:=idle;
signal STEP_CNT: std_logic_vector(2 downto 0):="000";
signal ROTATE_CNT: std_logic_vector(2 downto 0):="000";

begin

proces_stare: process(Clk)
begin
    if (Rst = '1') then
        state <= idle;
    else
        if (Clk = '1' and Clk'event) then
            case state is
                when idle =>
                            if (Start = '1') then
                                state <= init;
                            else
                                state <= idle;
                            end if;
                            STEP_CNT <= "100";
                            ROTATE_CNT <= "100";
                            
                when init => state <= multiplyDigits;
                when multiplyDigits => --state <= shiftA_rotateB;
                                        state <= testRotate;
                                       ROTATE_CNT <= ROTATE_CNT - 1;
                --when shiftA_rotateB => state <= testRotate;
                when testRotate => if (ROTATE_CNT > 0) then
                                        state <= multiplyDigits;
                                   else
                                        state <= shiftAQ;
                                        STEP_CNT <= STEP_CNT - 1;
                                   end if;
                when shiftAQ => state <= testC;
                when testC => if (STEP_CNT > 0) then
                                    state <= multiplyDigits;
                                    ROTATE_CNT <= "100";
                                else 
                                    state <= stop;
                                end if;
                when others => state <= stop;
            end case;
        end if;
    end if;
end process;

proces_iesiri: process(state)
begin
    case state is
        when idle => LoadA <= '0';
                     RstA <= '1';
                     LoadQ <= '0';
                     RstQ <= '1';
                     LoadB <= '0';
                     RstB <= '1';
                     muxB <= '0';
                     shrAQ <= '0';
                     shiftRightAZ <= '0';
                     CET1 <= '0';
                     RstT1 <= '1';
                     CET2 <= '0';
                     RstT2 <= '1';
                     control <= '0';
                     Term <= '0';
                     
       when init =>  LoadA <= '0';
                     RstA <= '1';
                     LoadQ <= '1';
                     RstQ <= '0';
                     LoadB <= '1';
                     RstB <= '0';
                     muxB <= '0';
                     shrAQ <= '0';
                     shiftRightAZ <= '0';
                     CET1 <= '0';
                     RstT1 <= '1';
                     CET2 <= '0';
                     RstT2 <= '1';
                     control <= '1';
                     Term <= '0';
                     
        when multiplyDigits => LoadA <= '0';
                               RstA <= '0';
                               LoadQ <= '0';
                               RstQ <= '0';
                               LoadB <= '1';
                               RstB <= '0';
                               muxB <= '1';
                               shrAQ <= '0';
                               shiftRightAZ <= '1';
                               CET1 <= '1';
                               RstT1 <= '0';
                               CET2 <= '1';
                               RstT2 <= '0';
                               control <= '1';
                               Term <= '0';
                               
          when testRotate =>   LoadA <= '0';
                               RstA <= '0';
                               LoadQ <= '0';
                               RstQ <= '0';
                               LoadB <= '0';
                               RstB <= '0';
                               muxB <= '0';
                               shrAQ <= '0';
                               shiftRightAZ <= '0';
                               CET1 <= '0';
                               RstT1 <= '0';
                               CET2 <= '0';
                               RstT2 <= '0';
                               control <= '0';
                               Term <= '0';
                               
           when shiftAQ => LoadA <= '0';
                               RstA <= '0';
                               LoadQ <= '0';
                               RstQ <= '0';
                               LoadB <= '0';
                               RstB <= '0';
                               muxB <= '0';
                               shrAQ <= '1';
                               shiftRightAZ <= '0';
                               CET1 <= '0';
                               RstT1 <= '1';
                               CET2 <= '0';
                               RstT2 <= '1';
                               control <= '0';
                               Term <= '0';
            
            when testC =>      LoadA <= '0';
                               RstA <= '0';
                               LoadQ <= '0';
                               RstQ <= '0';
                               LoadB <= '0';
                               RstB <= '0';
                               muxB <= '0';
                               shrAQ <= '0';
                               shiftRightAZ <= '0';
                               CET1 <= '0';
                               RstT1 <= '0';
                               CET2 <= '0';
                               RstT2 <= '0';
                               control <= '0';
                               Term <= '0';
           
           when stop =>        LoadA <= '0';
                               RstA <= '0';
                               LoadQ <= '0';
                               RstQ <= '0';
                               LoadB <= '0';
                               RstB <= '0';
                               muxB <= '0';
                               shrAQ <= '0';
                               shiftRightAZ <= '0';
                               CET1 <= '0';
                               RstT1 <= '0';
                               CET2 <= '0';
                               RstT2 <= '0';
                               control <= '0';
                               Term <= '1';
        
    end case;
end process;

end Behavioral;
