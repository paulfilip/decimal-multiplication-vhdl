library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SRRN_TB is
--  Port ( );
end SRRN_TB;

architecture Behavioral of SRRN_TB is

signal Clk: std_logic:='0';
signal D: std_logic_vector(15 downto 0):=x"0000";
signal SRI: std_logic_vector(3 downto 0):="0000";
signal Rst: std_logic;
signal CE: std_logic:='0';
signal Load: std_logic:='0';
signal Q: std_logic_vector(15 downto 0);

begin

DUT: entity WORK.SRRN 
generic map (n=>16) 
port map(
    Clk => Clk, 
    D => D, 
    SRI => SRI, 
    Rst => Rst, 
    CE => CE, 
    Load => Load, 
    Q => Q);

clk <= not clk after 5 ns;

gen_vect_test: process
    begin
        Rst <= '1';
        wait for 10 ns;
        
        Rst <= '0';
        D <= x"1234";
        Load <= '1';
        wait for 10 ns;
        
        Load <= '0';
        SRI <= x"5";
        CE <= '1';
        wait for 10 ns;
        
        Rst <= '1';
        wait for 10 ns;
        
        Rst <= '0';
        SRI <= x"4";
        wait for 10 ns;
        
        SRI <= x"3";
        wait for 10 ns;
        
        SRI <= x"2";
        wait for 10 ns;
        
        SRI <= x"1";
        wait for 10 ns;        
    end process;
    
end Behavioral;