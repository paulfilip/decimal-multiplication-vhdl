
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ModulPrincpilal is
Port (
    Clk: IN std_logic;
    Rst: IN std_logic;
    StepStart: IN std_logic;
    sw: IN std_logic_vector(15 downto 0);
    An: out STD_LOGIC_VECTOR(7 downto 0);
    Seg: out STD_LOGIC_VECTOR(7 downto 0);
    led: out STD_LOGIC_VECTOR(14 downto 0);
    Term: out STD_LOGIC );
end ModulPrincpilal;

architecture Behavioral of ModulPrincpilal is


signal StepStartSignal: std_logic;
signal whichState: std_logic_vector(7 downto 0);
signal TermOp: std_logic;
signal X: std_logic_vector(15 downto 0);
signal Y: std_logic_vector(15 downto 0);
signal signX: std_logic;
signal signY: std_logic;
signal metoda: std_logic_vector(1 downto 0);
signal Term1: std_logic;
signal Term2: std_logic;
signal Term3: std_logic;
signal StartT1: std_logic;
signal P1: std_logic_vector(31 downto 0);
signal sign1: std_logic;
signal StartT2: std_logic;
signal P2: std_logic_vector(31 downto 0);
signal sign2: std_logic;
signal StartT3: std_logic;
signal P3: std_logic_vector(31 downto 0);
signal sign3: std_logic;
signal sign: std_logic;
signal P: std_logic_vector(31 downto 0);
signal Data:std_logic_vector(31 downto 0);
signal errorX: std_logic:='0';
signal errorY: std_logic:='0';
signal errorMethod: std_logic:='0';
signal error:std_logic;
signal enableMetodaRegistru: std_logic;
signal enableSignXReg: std_logic;
signal enableSignYReg: std_logic;
signal enableXReg: std_logic;
signal enableYReg: std_logic;

begin

TermOp <= Term1 or Term2 or Term3;
Term <= whichState(0);
sign <= sign1 or sign2 or sign3;
enableSignXReg <= whichState(5) and StepStartSignal;
enableSignYReg <= whichState(3) and StepStartSignal;
enableMetodaRegistru <= whichState(6) and StepStartSignal;
enableXReg <= whichState(4) and StepStartSignal;
enableYReg <= whichState(2) and StepStartSIgnal;
error <= errorMethod or errorX or errorY;

debouncer_StepStart: entity WORK.Debouncer_circuit port map (Clk => Clk, Rst => Rst, D_IN => StepStart, Q_OUT => StepStartSignal);
UCP: entity WORK.UC_principal port map (Clk => Clk, Rst => Rst, Step => StepStartSignal, Error => error, TermOp => TermOp, whichState => whichState);

RegistruX: entity WORK.bistabilN_reset_sincron generic map (n => 16) port map (Clk => Clk, Rst => Rst, CE => enableXReg , D => sw, Q => X);
RegistruY: entity WORK.bistabilN_reset_sincron generic map (n => 16) port map (Clk => Clk, Rst => Rst, CE => enableYReg, D => sw, Q => Y);

bistabilSemnX: entity WORK.bistabil_reset_sincron port map (Clk => Clk, Rst => Rst, CE => enableSignXReg , D =>sw(15), Q => signX );
bistabilSemnY: entity WORK.bistabil_reset_sincron port map (Clk => Clk, Rst => Rst, CE => enableSignYReg , D =>sw(15), Q => signY );

RegistruMetoda: entity WORK.bistabilN_reset_sincron generic map (n => 2) port map (Clk => Clk, Rst => Rst, CE => enableMetodaRegistru, D => sw(15 downto 14), Q => metoda);

Circuit1: entity WORK.Inmultire_zecimala_M1 port map (Clk => Clk, signX => signX, X => X, signY => signY, Y => Y, Rst => Rst, Start => StartT1, P => P1, sign => sign1, Term => Term1);
Circuit2: entity WORK.Inmultire_zecimala_M2 port map (Clk => Clk, signX => signX, X => X, signY => signY, Y => Y, Rst => Rst, Start => StartT2, P => P2, sign => sign2, Term => Term2);
Circuit3: entity WORK.Inmultire_zecimala_M3 port map (Clk => Clk, signX => signX, X => X, signY => signY, Y => Y, Rst => Rst, Start => StartT3, P => P3, sign => sign3, Term => Term3);

led(14 downto 8) <= whichState(7 downto 1);
led(7) <= signX;
led(6) <= signY;
led(5) <= sign;
led(4) <= errorX;
led(3) <= errorY;
led(2) <= errorMethod;
led(1 downto 0) <= metoda;

proces_start: process(Clk)
begin
if(rising_edge(Clk)) then
    if(whichState(2) = '1') then
        if(StepStartSignal = '1') then
        case metoda is
            when "01" => StartT1 <= '1';
                         StartT2 <= '0';
                         StartT3 <= '0';
            when "10" => StartT1 <= '0';
                         StartT2 <= '1';
                         StartT3 <= '0';
            when "11" => StartT1 <= '0';
                         StartT2 <= '0';
                         StartT3 <= '1';
            when others => StartT1 <= '0';
                         StartT2 <= '0';
                         StartT3 <= '0';
        end case;
    end if;
    end if;
end if;
end process;

display: entity WORK.displ7seg port map (Clk => Clk, Rst => Rst, Data => Data, An => An, Seg => Seg);

P <= P1 when metoda="01" else P2 when metoda="10" else P3 when metoda="11" else x"00000000";

proces_date_ssd: process(Clk)
begin
    if(error = '1') then
        Data <= x"EEEE0000";
    else
        if (whichState(0) = '1') then
            if(sw(0) = '0') then
                Data <= P;
            else
                Data <= X & Y;
            end if;
        else
            case whichState is
                when "01000000" => Data <= "00" & sw(15 downto 14)  & x"0000000";
                when "00010000" => Data <= sw & Y;
                when "00000100" => Data <= X & sw;
                when others => Data <= X & Y;
            end case;
        end if;
       end if;
end process;

errorMethod <= '1' when metoda ="00" and whichState(7 downto 6) = "00"  else '0';
errorX <= '1' when X(15 downto 12)>"1001" or X(11 downto 8)>"1001" or X(7 downto 4)>"1001" or X(3 downto 0)>"1001" else '0';
errorY <= '1' when Y(15 downto 12)>"1001" or Y(11 downto 8)>"1001" or Y(7 downto 4)>"1001" or Y(3 downto 0)>"1001" else '0';

end Behavioral;
