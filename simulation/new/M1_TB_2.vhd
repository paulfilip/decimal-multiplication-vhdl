library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity M1_TB_2 is
--  Port ( );
end M1_TB_2;

architecture Behavioral of M1_TB_2 is
signal Clk: std_logic:='0';
signal X: std_logic_vector(15 downto 0);
signal Y: std_logic_vector(15 downto 0);
signal Rst: std_logic;
signal Start: std_logic;
signal P: std_logic_vector(31 downto 0):=x"00000000";
signal Term: std_logic;

begin

DUT: entity WORK.Inmultire_zecimala_M1 port map (Clk => Clk, X => X, Y => Y,signX => '1', signY => '1', Rst => Rst, Start => Start, P => P, Term => Term);
Clk <= not Clk after 5 ns;
gen_vect_test:process
begin
    Rst <= '1';
    wait for 10 ns;
    Start <= '1';
    Rst <= '0';
    X <= x"4567";
    Y <= x"5921";
    wait for 5000 ns;
    
--    Rst <= '1';
--    wait for 10 ns;
    
--    Rst <= '0';
--    X <= x"4444";
--    Y <= x"4455";
--    wait for 250 ns;
    
--    Rst <= '1';
--    wait for 10 ns;
    
--    Rst <= '0';
--    X <= x"9999";
--    Y <= x"9999";
--    wait for 250  ns;
end process;

end Behavioral;
