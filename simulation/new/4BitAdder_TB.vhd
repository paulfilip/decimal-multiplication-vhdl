library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIc_ARITH.ALL;

entity BitAdder4_TB is
--  Port ( );
end BitAdder4_TB;

architecture Behavioral of BitAdder4_TB is

signal X: STD_LOGIC_VECTOR(3 downto 0);
signal Y: STD_LOGIC_VECTOR(3 downto 0);
signal S: STD_LOGIC_VECTOR(3 downto 0);
signal Tin: STD_LOGIC;
signal Tout: STD_LOGIC;

begin

DUT: entity WORK.Binary_Adder_4bits port map (X => X,
Y => Y,
Tin => Tin,
S => S,
Tout => Tout);

gen_vet_test: process

variable xVar: STD_LOGIC_VECTOR(3 downto 0);
variable yVar: STD_LOGIC_VECTOR(3 downto 0);
variable TrIn: STD_LOGIC;

begin
    TrIn:='0';
    xVar:="0000";
    for i in 0 to 15 loop
        yVar:="0000";
        for j in 0 to 15 loop
            X <= xVar;
            Y <= yVar;
            Tin <= TrIn;
            wait for 10 ns;
            yVar:=yVar+1;
        end loop;
        xVar:=xVar+1;
    end loop;
end process;
end Behavioral;
