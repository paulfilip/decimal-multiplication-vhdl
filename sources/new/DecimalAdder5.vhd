library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecimalAdder5 is
Port (
    X: IN std_logic_vector(19 downto 0);
    Y: IN std_logic_vector(19 downto 0);
    Tin: IN std_logic;
    S: OUT std_logic_vector(19 downto 0);
    Tout: OUT std_logic );
end DecimalAdder5;

architecture Behavioral of DecimalAdder5 is

signal T1: STD_LOGIC;
signal T2: STD_LOGIC;
signal T3: STD_LOGIC;
signal T4: STD_LOGIC;

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
             Tout => T4);

sum_zeci_mii: entity WORK.Decimal_Adder port map(
             X => X(19 downto 16),
             Y => Y(19 downto 16),
             Tin => T4,
             S => S(19 downto 16),
             Tout => Tout);

end Behavioral;
