library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Decimal_Adder is
Port (
    X: IN STD_LOGIC_VECTOR(3 downto 0);
    Y: IN STD_LOGIC_VECTOR(3 downto 0);
    Tin: IN STD_LOGIC;
    S: OUT STD_LOGIC_VECTOR(3 downto 0);
    Tout: OUT STD_LOGIC);
end Decimal_Adder;

architecture Behavioral of Decimal_Adder is

signal S1: STD_LOGIC_VECTOR(3 downto 0);
signal T1: STD_LOGIC;
signal X2: STD_LOGIC_VECTOR(3 downto 0);
signal Tf: STD_LOGIC;
signal T2: STD_LOGIC;

begin

sum1: entity WORK.Binary_Adder_4bits port map(
X => X,
Y => Y,
Tin => Tin,
S => S1,
Tout => T1);

Tf <= T1 or (S1(3) and S1(2)) or (S1(3) and S1(1));
Tout <= Tf;

X2 <= "0110" when Tf = '1' else "0000";

sum2: entity WORK.Binary_Adder_4bits port map(
X => X2,
Y => S1,
Tin => '0',
S => S,
Tout => T2);
end Behavioral;
