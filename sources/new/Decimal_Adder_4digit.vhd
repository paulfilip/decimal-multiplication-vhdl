library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decimal_Adder_4digit is
Port (
X: IN STD_LOGIC_VECTOR(15 downto 0);
Y: IN STD_LOGIC_VECTOR(15 downto 0);
Tin: IN STD_LOGIC;
S: OUT STD_LOGIC_VECTOR(15 downto 0);
Tout: OUT STD_LOGIC);

end Decimal_Adder_4digit;

architecture Behavioral of Decimal_Adder_4digit is
signal T1: STD_LOGIC;
signal T2: STD_LOGIC;
signal T3: STD_LOGIC;
begin
sum_unitati: entity WORK.Decimal_Adder port map(
           X => X(3 downto 0),
           Y => Y(3 downto 0),
           Tin => Tin,
           S => S(3 downto 0),
           Tout => T1);

sum_zeci: entity WORK.Decimal_Adder port map(
            X => X(7 downto 4),
            Y => Y(7 downto 4),
            Tin => T1,
            S => S(7 downto 4),
            Tout => T2);

sum_sute: entity WORK.Decimal_Adder port map(
            X => X(11 downto 8),
            Y => Y(11 downto 8),
            Tin => T2,
            S => S(11 downto 8),
            Tout => T3);

sum_mii: entity WORK.Decimal_Adder port map(
             X => X(15 downto 12),
             Y => Y(15 downto 12),
             Tin => T3,
             S => S(15 downto 12),
             Tout => Tout);

end Behavioral;
