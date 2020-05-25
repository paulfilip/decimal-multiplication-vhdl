library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TableMultiplication_TB is
--  Port ( );
end TableMultiplication_TB;

architecture Behavioral of TableMultiplication_TB is

signal X: STD_LOGIC_VECTOR(3 downto 0);
signal Y: STD_LOGIC_VECTOR(3 downto 0);
signal R: STD_LOGIC_VECTOR(7 downto 0);

begin

DUT: entity WORK.ROM_Multiples port map (
    X => X,
    Y => Y,
    R => R);
    
gen_vect_test: process
variable xVar: STD_LOGIC_VECTOR(3 downto 0);
variable yVar: STD_LOGIC_VECTOR(3 downto 0);
begin
    xVar:="0000";
    for i in 0 to 9 loop
        yVar:="0000";
        for j in 0 to 9 loop
            X <= xVar;
            Y <= yVar;
            wait for 10 ns;
            yVar:=yVar + 1;
        end loop;
        xVar:=xVar + 1;
    end loop;
end process;
end Behavioral;
