library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC1_TB is
--  Port ( );
end UC1_TB;

architecture Behavioral of UC1_TB is

signal Clk: std_logic:='0';
signal Rst: std_logic;
signal Start: std_logic;
signal Q0: std_logic_vector(3 downto 0);
signal LoadB: std_logic;
signal RstA: std_logic;
signal LoadA: std_logic;
signal LoadQ: std_logic;
signal shrAQ: std_logic;
signal Term: std_logic;
signal RstQ: std_logic;
signal RstB: std_logic;
constant CLK_PERIOD:TIME:=10ns;    
begin

Clk <= not Clk after (CLK_PERIOD/2);

DUT: entity WORK.UC_metoda1 port map (Clk => Clk,
                                      Rst => Rst,
                                      Start => Start,
                                      Q0 => Q0,
                                      LoadB => LoadB,
                                      RstA => RstA,
                                      RstQ => RstQ,
                                      RstB => RstB,
                                      LoadA => LoadA,
                                      LoadQ => LoadQ,
                                      shrAQ => shrAQ,
                                      Term => Term);

gen_vect_test: process
begin
    Rst <= '0';
    wait for (CLK_PERIOD/2);
    
    Rst <= '0';
    Start <= '1';
    Q0 <= "0101";
    wait for (CLK_PERIOD/2)*12;
    
    
end process;
end Behavioral;
