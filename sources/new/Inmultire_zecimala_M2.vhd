library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Inmultire_zecimala_M2 is
Port (
    Clk: IN std_logic;
    signX: IN std_logic;
    X: IN std_logic_vector(15 downto 0);
    signY: IN std_logic;
    Y: IN std_logic_vector(15 downto 0);
    Rst: IN std_logic;
    Start: IN std_logic;
    P: OUT std_logic_vector(31 downto 0);
    sign: OUT std_logic;
    Term: OUT std_logic );
end Inmultire_zecimala_M2;

architecture Behavioral of Inmultire_zecimala_M2 is

signal    LoadA: std_logic;
signal    RstA: std_logic;
signal    LoadQ: std_logic;
signal    RstQ: std_logic;
signal    shrAQ: std_logic;
signal    LoadX: std_logic_vector(8 downto 0);
signal    RstX: std_logic_vector(8 downto 0);
signal    MuxInit: std_logic;

signal Reg1XOut: std_logic_vector(19 downto 0);
signal Reg2XOut: std_logic_vector(19 downto 0);
signal Reg3XOut: std_logic_vector(19 downto 0);
signal Reg4XOut: std_logic_vector(19 downto 0);
signal Reg5XOut: std_logic_vector(19 downto 0);
signal Reg6XOut: std_logic_vector(19 downto 0);
signal Reg7XOut: std_logic_vector(19 downto 0);
signal Reg8XOut: std_logic_vector(19 downto 0);
signal Reg9XOut: std_logic_vector(19 downto 0);

signal comparatorOUT: std_logic_vector(9 downto 0);
signal AccOut: std_logic_vector(19 downto 0);
signal A0: std_logic_vector(3 downto 0);
signal Qout: std_logic_vector(15 downto 0);
signal Q0: std_logic_vector(3 downto 0);
signal firstOperand: std_logic_vector(19 downto 0);
signal sumatorOUT: std_logic_vector(19 downto 0);
signal SumatorTOut: std_logic;
signal whichRegister: std_logic_vector(19 downto 0);
signal Reg1XIN: std_logic_vector(19 downto 0);

begin

sign <= signX xor signY;
A0 <= AccOut(3 downto 0);
Q0 <= Qout(3 downto 0);

UCP: entity WORK.UC_metoda2 port map( Clk => Clk,
                                      Rst => Rst,
                                      Start => Start,
                                      LoadA => LoadA,
                                      RstA => RstA,
                                      RstQ => RstQ,
                                      LoadQ => LoadQ,
                                      shrAQ => shrAQ,
                                      MuxInit => MuxInit,
                                      LoadX => LoadX,
                                      RstX => RstX,
                                      Term => Term);
Reg1XIN <= "0000" & X;                               
Reg1X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(0), CE => LoadX(0), D => Reg1XIN, Q => Reg1XOut);
Reg2X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(1), CE => LoadX(1), D => SumatorOUT, Q => Reg2XOut);
Reg3X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(2), CE => LoadX(2), D => SumatorOUT, Q => Reg3XOut);
Reg4X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(3), CE => LoadX(3), D => SumatorOUT, Q => Reg4XOut);
Reg5X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(4), CE => LoadX(4), D => SumatorOUT, Q => Reg5XOut);
Reg6X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(5), CE => LoadX(5), D => SumatorOUT, Q => Reg6XOut);
Reg7X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(6), CE => LoadX(6), D => SumatorOUT, Q => Reg7XOut);
Reg8X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(7), CE => LoadX(7), D => SumatorOUT, Q => Reg8XOut);
Reg9X: entity WORK.bistabilN_reset_sincron generic map( n => 20) port map (Clk => Clk, Rst => RstX(8), CE => LoadX(8), D => SumatorOUT, Q => Reg9XOut);

Accumulator: entity WORK.SRRN generic map(n=>20) port map(Clk => Clk, D => SumatorOUT, SRI => "0000", Rst => RstA, CE => shrAQ, Load => LoadA, Q => AccOut);
Registru_Q: entity WORK.SRRN generic map(n=>16) port map(Clk => Clk, D => Y, SRI => A0, Rst => RstQ, CE => shrAQ, Load => LoadQ, Q => Qout);
Sumator_zecimal: entity WORK.DecimalAdder5 port map(X => firstOperand,Y => AccOut, Tin => '0' ,S => SumatorOUT , Tout => SumatorTOut );

proces_comparator: process(Q0)
begin
    case Q0 is
        when "0000" => comparatorOUT <= "0000000001";
        when "0001" => comparatorOUT <= "0000000010";
        when "0010" => comparatorOUT <= "0000000100";
        when "0011" => comparatorOUT <= "0000001000";
        when "0100" => comparatorOUT <= "0000010000";
        when "0101" => comparatorOUT <= "0000100000";
        when "0110" => comparatorOUT <= "0001000000";
        when "0111" => comparatorOUT <= "0010000000";
        when "1000" => comparatorOUT <= "0100000000";
        when "1001" => comparatorOUT <= "1000000000";
        when others => comparatorOUT <= "0000000000";
    end case;
end process;

alegere_registru: process(clk, comparatorOUT)
begin
    case comparatorOUT is
        when "0000000001" => whichRegister <= x"00000";
        when "0000000010" => whichRegister <= Reg1XOut;
        when "0000000100" => whichRegister <= Reg2XOut;
        when "0000001000" => whichRegister <= Reg3XOut;
        when "0000010000" => whichRegister <= Reg4XOut;
        when "0000100000" => whichRegister <= Reg5XOut;
        when "0001000000" => whichRegister <= Reg6XOut;
        when "0010000000" => whichRegister <= Reg7XOut;
        when "0100000000" => whichRegister <= Reg8XOut;
        when "1000000000" => whichRegister <= Reg9XOut;
        when others => whichRegister <= x"00000";
    end case;
end process; 
  
firstOperand <= Reg1XOut when MuxInit = '1' else whichRegister;

P <= AccOut(15 downto 0) & Qout;
end Behavioral;
