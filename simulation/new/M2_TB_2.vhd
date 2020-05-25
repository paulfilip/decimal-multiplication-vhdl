library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity M2_TB_2 is
--  Port ( );
end M2_TB_2;

architecture Behavioral of M2_TB_2 is

signal    Clk: std_logic:='0';
signal    signX: std_logic;
signal    X: std_logic_vector(15 downto 0);
signal    signY: std_logic;
signal    Y: std_logic_vector(15 downto 0);
signal    Rst: std_logic;
signal    Start: std_logic;
signal    P: std_logic_vector(31 downto 0);
signal    sign: std_logic;
signal    Term: std_logic;

constant CLK_PERIOD:time:=10 ns;

begin

DUT: entity WORK.Inmultire_zecimala_M2 port map(
                                        Clk => Clk,
                                        signX => signX,
                                        X => X,
                                        signY => signY,
                                        Y => Y,
                                        Rst => Rst,
                                        Start => Start,
                                        P => P,
                                        sign => sign,
                                        Term => Term);
    
Clk <= not Clk after (CLK_PERIOD/2);                                    
gen_vect_test: process
begin
    Rst <= '1';
    wait for 10 ns;
    Start <= '1';
    Rst <= '0';
    X <= x"0003";
    Y <= x"0051";
    wait for 5000 ns;
end process;
end Behavioral;
