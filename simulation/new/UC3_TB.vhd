library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC3_TB is
--  Port ( );
end UC3_TB;

architecture Behavioral of UC3_TB is

signal    Clk: std_logic:='0';
signal    Rst: std_logic;
signal    Start: std_logic;
signal    LoadA: std_logic;
signal    RstA: std_logic;
signal    LoadQ: std_logic;
signal    RstQ: std_logic;
signal    LoadB: std_logic;
signal    RstB: std_logic;
signal    muxB: std_logic;
signal    shrAQ: std_logic;
signal    shiftRightAZ: std_logic;
signal    CET1: std_logic;
signal    RstT1: std_logic;
signal    CET2: std_logic;
signal    RstT2: std_logic;
signal    control: std_logic;
signal    Term: std_logic;
constant CLK_PERIOD:time:=10 ns;

begin

Clk <= not Clk after (CLK_PERIOD/2);

DUT: entity WORK.UC_metoda3 port map ( Clk => Clk,
                                       Rst => Rst,
                                       Start => Start,
                                       LoadA => LoadA,
                                       RstA => RstA,
                                       LoadQ => LoadQ,
                                       RstQ => RstQ,
                                       LoadB => LoadB,
                                       RstB => RstB,
                                       muxB => muxB,
                                       shrAQ => shrAQ,
                                       shiftRightAZ => shiftRightAZ,
                                       CET1 => CET1,
                                       RstT1 => RstT1,
                                       CET2 => CET2,
                                       RstT2 => RstT2,
                                       control => control,
                                       Term => Term);

gen_vect_test: process
begin
    Rst <= '1';
    wait for (CLK_PERIOD/2);
    Rst <= '0';
    wait for (CLK_PERIOD/2);
    
    Start <= '1';
    wait for (CLK_PERIOD/2);
    Start <= '0';
    wait for (CLK_PERIOD/2)*100;
end process;

end Behavioral;
