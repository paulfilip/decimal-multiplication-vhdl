library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UCM2_TB is
--  Port ( );
end UCM2_TB;

architecture Behavioral of UCM2_TB is

signal    Clk: std_logic:='0';
signal    Rst: std_logic;
signal    Start: std_logic;
signal    LoadA: std_logic;
signal    RstA: std_logic;
signal    LoadQ: std_logic;
signal    RstQ: std_logic;
signal    shrAQ: std_logic;
signal    LoadX: std_logic_vector(8 downto 0);
signal    Term: std_logic;

constant CLK_PERIOD:TIME:=10ns; 

begin

Clk <= not Clk after (CLK_PERIOD/2);

DUT: entity WORK.UC_metoda2 port map(
                                      Clk => Clk,
                                      Rst => Rst,
                                      Start => Start,
                                      LoadA => LoadA,
                                      RstA => RstA,
                                      RstQ => RstQ,
                                      LoadQ => LoadQ,
                                      shrAQ => shrAQ,
                                      LoadX => LoadX,
                                      Term => Term);
                                      
gen_vect_test: process
begin
    Rst <= '1';
    wait for (CLK_PERIOD/2);
    
    Rst <= '0';
    Start <='1';
    wait for 50*(CLK_PERIOD/2);
end process;
end Behavioral;
