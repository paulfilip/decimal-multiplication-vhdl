library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Inmultire_zecimala_M3_TB is
--  Port ( );
end Inmultire_zecimala_M3_TB;

architecture Behavioral of Inmultire_zecimala_M3_TB is
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

Clk <= not Clk after (CLK_PERIOD/2);

DUT: entity WORK.Inmultire_zecimala_M3 port map ( 
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

gen_vect_test: process
begin
    Rst <= '1';
    wait for 10 ns;
    Start <= '1';
    Rst <= '0';
    X <= x"9999";
    Y <= x"9999";
    wait for 5000 ns;
end process;

end Behavioral;
