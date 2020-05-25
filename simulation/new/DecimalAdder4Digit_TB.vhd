library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DecimalAdder4Digit_TB is
--  Port ( );
end DecimalAdder4Digit_TB;

architecture Behavioral of DecimalAdder4Digit_TB is
signal X: STD_LOGIC_VECTOR(15 downto 0);
signal Y: STD_LOGIC_VECTOR(15 downto 0);
signal S: STD_LOGIC_VECTOR(15 downto 0);
signal Tin: STD_LOGIC;
signal Tout: STD_LOGIC;

begin

DUT: entity WORK.Decimal_Adder_4digit port map(
    X => X,
    Y => Y,
    Tin => Tin,
    S => S,
    Tout => Tout
);

gen_vect_test: process
begin
    Tin <= '0';
    X <= x"0001";
    Y <= x"0010";
    wait for 10 ns;
    
    X <= x"2638";
    Y <= x"4752";
    wait for 10 ns;
    
    X <= x"9999";
    Y <= x"9999";
    wait for 10 ns;
    
    X <= x"9009";
    Y <= x"0990";
    wait for 10 ns;
    
    X <= x"1234";
    Y <= x"6789";
    wait for 10 ns;
    
    X <= x"0099";
    Y <= x"0102";
    wait for 10 ns;
    
    X <= x"3500";
    Y <= x"6501";
    wait for 10 ns;
    
    X <= x"9999";
    Y <= x"0002";
    wait for 10 ns;
    
end process;
end Behavioral;
