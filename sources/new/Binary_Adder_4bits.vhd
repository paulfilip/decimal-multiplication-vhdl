library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Binary_Adder_4bits is
Port (
    X: IN STD_LOGIC_VECTOR(3 downto 0);
    Y: IN STD_LOGIC_VECTOR(3 downto 0);
    Tin: IN STD_LOGIC;
    S: OUT STD_LOGIC_VECTOR(3 downto 0);
    Tout: OUT STD_LOGIC);
end Binary_Adder_4bits;

architecture Behavioral of Binary_Adder_4bits is

signal P: STD_LOGIC_VECTOR(3 downto 0);
signal G: STD_LOGIC_VECTOR(3 downto 0);
signal T1: STD_LOGIC;
signal T2: STD_LOGIC;
signal T3: STD_LOGIC;

begin

gen_P_G: process(X, Y)
begin
    for i in 0 to 3 loop
        P(i) <= X(i) or Y(i);
        G(i) <= X(i) and Y(i);
    end loop;
end process;

T1 <= G(0) or (P(0) and Tin);
T2 <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Tin);
T3 <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Tin);

S(0) <= X(0) xor Y(0) xor Tin ;
S(1) <= X(1) xor Y(1) xor T1;
S(2) <= X(2) xor Y(2) xor T2;
S(3) <= X(3) xor Y(3) xor T3;

Tout <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Tin);
end Behavioral;
