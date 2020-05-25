library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bistabilN_TB is
--  Port ( );
end bistabilN_TB;

architecture Behavioral of bistabilN_TB is

signal Clk:std_logic:='0';
signal Rst: std_logic;
signal CE: std_logic:='1';
signal D: std_logic_vector(15 downto 0);
signal Q: std_logic_vector(15 downto 0);
    
begin

Clk <= not Clk after 5 ns;

DUT: entity WORK.bistabilN_reset_sincron generic map (n=>16) port map (Clk => Clk, Rst => Rst, CE => CE, D => D, Q => Q);
gen_vect_test: process
begin
    Rst <= '1';
    wait for 10 ns;
    
    Rst <= '0';
    wait for 5 ns;
   
    D <= x"1234";
    wait for 5 ns;
    
    CE <= '0';
    D <= x"9876";
    wait for 5 ns;
    
    CE <= '1';
    wait for 5 ns;
    
end process;
end Behavioral;
