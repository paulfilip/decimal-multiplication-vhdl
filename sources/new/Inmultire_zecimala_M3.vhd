library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Inmultire_zecimala_M3 is
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
end Inmultire_zecimala_M3;

architecture Behavioral of Inmultire_zecimala_M3 is

signal    LoadA: std_logic;
signal    RstA: std_logic;
signal    LoadQ: std_logic;
signal    RstQ: std_logic;
signal    LoadB: std_logic;
signal    RstB: std_logic;
signal    muxB: std_logic;
signal    shrAQ: std_logic;
signal    shiftRightAZ: std_logic;
signal    CET1: std_logic;
signal    RstT1: std_logic;
signal    CET2: std_logic;
signal    RstT2: std_logic;
signal    control: std_logic;
signal    TermSignal: std_logic;

signal Bout: std_logic_vector(15 downto 0);
signal B0: std_logic_vector(3 downto 0);
signal B_rotated: std_logic_vector(15 downto 0);
signal D_In_B: std_logic_vector(15 downto 0);
signal D_in_accumulator: std_logic_vector(15 downto 0):=x"0000";
signal SRI_Accumulator: std_logic_vector(3 downto 0);
signal Accout: std_logic_vector(15 downto 0);
signal A0: std_logic_vector(3 downto 0);
signal Qout: std_logic_vector(15 downto 0);
signal Q0: std_logic_vector(3 downto 0);
signal ROM_out: std_logic_vector(7 downto 0);
signal T1_out: std_logic_vector(3 downto 0);
signal SZ1_first_operand: std_logic_vector(7 downto 0);
signal SZ1_second_operand: std_logic_vector(7 downto 0);
signal SZ1_out: std_logic_vector(7 downto 0);
signal SZ1_Tout: std_logic;
signal SZ2_operand: std_logic_vector(3 downto 0);
signal SZ2_operand2: std_logic_vector(3 downto 0);
signal SZ2_out: std_logic_vector(3 downto 0);
signal SZ2_Tout: std_logic;
signal T2_out: std_logic;
signal shiftA: std_logic;
    
begin

sign <= signX xor signY;
Term <= TermSignal;
P <= Accout & Qout;

B_rotated <= Bout(3 downto 0) & Bout(15 downto 4);
D_In_B <= B_rotated when muxB = '1' else X;

A0 <= Accout(3 downto 0);
Q0 <= Qout(3 downto 0);
B0 <= Bout(3 downto 0);

SZ1_first_operand <= ROM_out when control = '1' else x"00";
SZ1_second_operand <= "0000" & T1_out;

SZ2_operand <= A0 when control = '1' else "0000";
SZ2_operand2 <= SZ1_out(3 downto 0) when control = '1' else T1_out;
SRI_Accumulator <= SZ2_out;

shiftA <= shrAQ or shiftRightAZ;

UCP: entity WORK.UC_metoda3 port map (
    Clk => Clk,
    Rst => Rst,
    Start => Start,
    LoadA => LoadA,
    RstA => RstA,
    LoadQ => LoadQ,
    RstQ => RstQ,
    LoadB => LoadB,
    RstB => RstB,
    muxB => muxB,
    shrAQ => shrAQ,
    shiftRightAZ => shiftRightAZ,
    CET1 => CET1,
    RstT1 => RstT1,
    CET2 => CET2,
    RstT2 => RstT2,
    control => control,
    Term => TermSignal);

Registru_X: entity WORK.bistabilN_reset_sincron generic map(n=>16) port map (Clk => Clk, Rst => RstB, CE => LoadB, D => D_In_B, Q => Bout);
Accumulator: entity WORK.SRRN generic map(n=>16) port map(Clk => Clk, D => D_in_accumulator, SRI => SRI_Accumulator, Rst => RstA, CE => shiftA, Load => loadA, Q => AccOut);
Registru_Q: entity WORK.SRRN generic map(n=>16) port map(Clk => Clk, D => Y, SRI => A0, Rst => RstQ, CE => shrAQ, Load => LoadQ, Q => Qout);
memROM: entity WORK.ROM_multiples port map (X => B0, Y => Q0, R => ROM_out);
Sumator_zecimal_1: entity WORK.Decimal_Adder_2digit port map (X => SZ1_first_operand, Y =>SZ1_second_operand, Tin => '0', S => SZ1_out, Tout =>SZ1_Tout);
Registru_T1: entity WORK.bistabilN_reset_sincron generic map(n=>4) port map (Clk => Clk, Rst => RstT1, CE => CET1, D => SZ1_out(7 downto 4), Q => T1_out);
Sumator_zecimal_2: entity WORK.Decimal_Adder port map (X => SZ2_operand2, Y => SZ2_operand, Tin =>T2_out, S => SZ2_out, Tout => SZ2_Tout);
Bistabil_T2: entity WORK.bistabil_reset_sincron port map (Clk => Clk, Rst => RstT2, CE => CET2, D => SZ2_Tout, Q => T2_out);
end Behavioral;
