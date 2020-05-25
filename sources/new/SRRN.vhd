library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SRRN is
generic(n:integer);
Port (
    Clk: IN std_logic;
    D: IN std_logic_vector(n-1 downto 0);
    SRI: IN std_logic_vector(3 downto 0);
    Rst: IN std_logic;
    CE: IN std_logic;
    Load: IN std_logic;
    Q: OUT std_logic_vector(n-1 downto 0));
end SRRN;

architecture Behavioral of SRRN is

signal temp: std_logic_vector(n-1 downto 0):=(others => '0');

begin

process(Clk)
begin
    if(clk = '1' and clk'event) then
        if(Rst = '1') then
            temp <= (others => '0');
        else
            if(Load = '1') then
                temp <= D;
            else
                if(CE = '1') then
                    temp <= SRI & temp(n-1 downto 4);
                end if;
            end if;
        end if;
    end if;
end process;

Q <= temp;
end Behavioral;
