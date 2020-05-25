library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decimal_Adder_TB is
--  Port ( );
end Decimal_Adder_TB;

architecture Behavioral of Decimal_Adder_TB is
signal X: STD_LOGIC_VECTOR(3 downto 0);
signal Y: STD_LOGIC_VECTOR(3 downto 0);
signal S: STD_LOGIC_VECTOR(3 downto 0);
signal Tin: STD_LOGIC;
signal Tout: STD_LOGIC;

begin

gen_vect_test: process
variable xVar: STD_LOGIC_VECTOR(3 downto 0);
variable yVar: STD_LOGIC_VECTOR(3 downto 0);
variable TrIn: STD_LOGIC;
begin
    xVar:="0000";
    TrIn:='0';
    for i in 0 to 9 loop
        yVar:="0000";
        for j in 0 to 9 loop
            X <= xVar;
            Y <= yVar;
            Tin <= TrIn;
            wait for 10 ns;
            yVar:=yVar + 1;
        end loop;
        xVar:=xVar + 1;
    end loop;
end process;

DUT: entity WORK.Decimal_Adder port map(
X => X,
Y => Y,
Tin => Tin,
S => S,
Tout => Tout);

end Behavioral;
