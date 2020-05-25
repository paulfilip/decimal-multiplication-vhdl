library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM_Multiples is
Port ( 
    X: IN STD_LOGIC_VECTOR(3 downto 0);
    Y: IN STD_LOGIC_VECTOR(3 downto 0);
    R: OUT STD_LOGIC_VECTOR(7 downto 0));
end ROM_Multiples;

architecture Behavioral of ROM_Multiples is

type romMemory is array(0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
signal multiplication_table: romMemory:= 
    (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"01",x"02",x"03",x"04",x"05",x"06",x"07",x"08",x"09",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"02",x"04",x"06",x"08",x"10",x"12",x"14",x"16",x"18",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"03",x"06",x"09",x"12",x"15",x"18",x"21",x"24",x"27",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"04",x"08",x"12",x"16",x"20",x"24",x"28",x"32",x"36",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"05",x"10",x"15",x"20",x"25",x"30",x"35",x"40",x"45",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"06",x"12",x"18",x"24",x"30",x"36",x"42",x"48",x"54",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"07",x"14",x"21",x"28",x"35",x"42",x"49",x"56",x"63",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"08",x"16",x"24",x"32",x"40",x"48",x"56",x"64",x"72",x"00",x"00",x"00",x"00",x"00",x"00",
    x"00",x"09",x"18",x"27",x"36",x"45",x"54",x"63",x"72",x"81",x"00",x"00",x"00",x"00",x"00",x"00",
    others => x"00");
begin

R <= multiplication_table(conv_integer(X & Y));

end Behavioral;
