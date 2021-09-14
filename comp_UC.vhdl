library ieee;
use ieee.std_logic_1164.all; 

entity UC is
    port(
        dec2uc              : in std_logic_vector(10 downto 0);
        NZ                  : in std_logic_vector(1 downto 0);
        cl, clk             : in std_logic;
        barramento_controle : out std_logic_vector(10 downto 0)
    );
end entity;

architecture UC_comp of UC is

    component contador is
        port (
            clk, cl : in std_logic;
            v       : out std_logic_vector(2 downto 0)
        );
    end component;
    
    signal snop,ssta,slda, sadd, sand, sor, snot, sjmp, sjn, sjz, shlt  : std_logic_vector(10 downto 0); 
    signal counter    : std_logic_vector(2 downto 0);
begin
    -- Contador
    contador_comp : contador port map(clk, cl, counter);
    
    -- MUX
    barramento_controle <=  snop when dec2uc="10000000000" else
                            ssta when dec2uc="01000000000" else
                            slda when dec2uc="00100000000" else
                            sadd when dec2uc="00010000000" else
                            sor  when dec2uc="00001000000" else
                            sand when dec2uc="00000100000" else
                            snot when dec2uc="00000010000" else
                            sjmp when dec2uc="00000001000" else
                            sjn  when dec2uc="00000000100" else
                            sjz  when dec2uc="00000000010" else
                            shlt when dec2uc="00000000001" else
                            (others => 'Z');


    ---- OPERACOES ----

    -- NOP
    snop(10) <= '1';
    snop(9)  <= '1';
    snop(8 downto 6) <= "000";
    snop(5)  <= counter(0) and not(counter(1)) and not(counter(2));
    snop(4)  <= '0';
    snop(3)  <= '0';
    snop(2)  <= not(counter(2)) and not(counter(1)) and not(counter(2));
    snop(1) <= counter(0) and not counter(1) and not counter(2);
    snop(0) <= not counter(0) and counter(1) and not counter(2);

    -- STA
    ssta(10) <= '1';
    ssta(9) <= counter(1) or not counter(2) or not counter(0);
    ssta(8 downto 6) <= "000";
    ssta(5) <=  not counter(1) and (counter(0) xor counter(2));
    ssta(4) <= '0';
    ssta(3) <= not counter(0) and counter(1) and counter(2);
    ssta(2) <= (not counter(1) and (counter(2) xnor counter(0))) or (counter(0) and counter(1) and not counter(2));
    ssta(1) <= not counter(1) and (counter(1) xor counter(2));
    ssta(0) <= not counter(0) and counter(1) and not counter(2);

    -- LDA
    slda(10) <= '1';
    slda(9) <= counter(1) or not counter(2) or not counter(0);
    slda(8 downto 6) <= "000";
    slda(5) <=  not counter(1) and (counter(0) xor counter(2));
    slda(4) <= counter(0) and counter(1) and counter(2);
    slda(3) <= '0';
    slda(2) <=  (not counter(1) and (counter(2) XNOR counter(0))) or (counter(0) and counter(1) and not counter(2));
    slda(1) <= (not counter(0) and counter(2)) or (not counter(1) and counter(0) and not counter(2));
    slda(0) <= counter(1) and not counter(0) and not counter(2);

    -- ADD
    sadd(10) <= '1';
    sadd(9) <= counter(1) or not counter(2) or not counter(0);
    sadd(8 downto 6) <= "001";
    sadd(5) <= not counter(1) and (counter(0) XOR counter(2));
    sadd(4) <= counter(0) and counter(1) and counter(2);
    sadd(3) <= '0';
    sadd(2) <=  (not counter(1) and (counter(2) XNOR counter(0))) or (counter(0) and counter(1) and not counter(2));
    sadd(1) <= (not counter(0) and counter(2)) or (not counter(1) and counter(0) and not counter(2));
    sadd(0) <= counter(1) and not counter(0) and not counter(2);

    -- AND
    sand(10) <= '1';
    sand(9) <= counter(1) or not counter(2) or not counter(0);
    sand(8 downto 6) <= "011";
    sand(5) <= not counter(1) and (counter(0) XOR counter(2));
    sand(4) <= counter(0) and counter(1) and counter(2);
    sand(3) <= '0';
    sand(2) <= (not counter(1) and (counter(2) XNOR counter(0))) or (counter(0) and counter(1) and not counter(2));
    sand(1) <= (not counter(0) and counter(2)) or (not counter(1) and counter(0) and not counter(2));
    sand(0) <= counter(1) and not counter(0) and not counter(2);

    -- OR
    sor(10) <= '1';
    sor(9) <= counter(1) or not counter(2) or not counter(0);
    sor(8 downto 6) <= "010";
    sor(5) <= not counter(1) and (counter(0) XOR counter(2));
    sor(4) <= counter(0) and counter(1) and counter(2);
    sor(3) <= '0';
    sor(2) <= (not counter(1) and (counter(2) XNOR counter(0))) or (counter(0) and counter(1) and not counter(2));
    sor(1) <= (not counter(0) and counter(2)) or (not counter(1) and counter(0) and not counter(2));
    sor(0) <= counter(1) and not counter(0) and not counter(2);

    -- NOT
    snot(10) <= '1';
    snot(9) <= '1';
    snot(8 downto 6) <= "100";
    snot(5) <= not counter(1) and counter(0) and not counter(2);
    snot(4) <= counter(0) and counter(1) and counter(2);
    snot(3) <= '0';
    snot(2) <= not counter(0) and not counter(1) and not counter(2);
    snot(1) <= counter(0) and not counter(1) and not counter(2);
    snot(0) <= not counter(0) and counter(1) and not counter(2);

    -- JMP
    sjmp(10) <= not counter(1) or not counter(2) or not counter(0);
    sjmp(9) <= counter(1) or not counter(2) or not counter(0);
    sjmp(8 downto 6) <= "000";
    sjmp(5) <= (not counter(1) and counter(0) and not counter(2)) or (counter(0) and counter(2) and counter(1));
    sjmp(4) <= '0';
    sjmp(3) <= '0';
    sjmp(2) <= (not counter(1) and (counter(2) XNOR counter(0))) or (counter(0) and counter(1) and not counter(2));
    sjmp(1) <= (not counter(0) and counter(2)) or (not counter(1) and counter(0) and not counter(2));
    sjmp(0) <= counter(1) and not counter(0) and not counter(2);

    -- JN
    sjn(10) <= '1';
    sjn(9) <= '1';
    sjn(8 downto 6) <= "000";
    sjn(5) <= counter(0) and not counter(2);
    sjn(4) <= '0';
    sjn(3) <= '0';
    sjn(2) <= not counter(0) and not counter(1) and not counter(2);
    sjn(1) <= counter(0) and not counter(1) and not counter(2);
    sjn(0) <= counter(1) and not counter(0) and not counter(2);
    sjn <= sjmp when NZ(1)='1';

    -- JZ
    sjz(10) <= '1';
    sjz(9) <= '1';
    sjz(8 downto 6) <= "000";
    sjz(5) <= counter(0) and not counter(2);
    sjz(4) <= '0';
    sjz(3) <= '0';
    sjz(2) <= not counter(0) and not counter(1) and not counter(2);
    sjz(1) <= counter(0) and not counter(1) and not counter(2);
    sjz(0) <= counter(1) and not counter(0) and not counter(2);
    sjz <= sjmp when NZ(0)='1';

    -- HLT
    shlt(10) <= '0';
    shlt(9) <= '0';
    shlt(8 downto 6) <= "000";
    shlt(5) <= '0';
    shlt(4) <= '0';
    shlt(3) <= '0';
    shlt(2) <= '0';
    shlt(1) <= '0';
    shlt(0) <= '0';


end architecture UC_comp;

