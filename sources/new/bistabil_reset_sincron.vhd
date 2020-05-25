library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bistabil_reset_sincron is
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    CE: IN std_logic;
    D: IN std_logic;
    Q: OUT std_logic );
end bistabil_reset_sincron;

architecture Behavioral of bistabil_reset_sincron is

begin

process(Clk)
begin
    if(clk = '1' and clk'event) then
        if(Rst = '1') then
            Q <= '0';
        else
            if(CE = '1') then
                Q <= D;
            end if;
        end if;
    end if;
end process;
end Behavioral;