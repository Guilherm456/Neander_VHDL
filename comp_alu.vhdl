library ieee;
use ieee.std_logic_1164.all; 

entity alu_mod is
    port(
        a,b: in std_logic_vector(7 downto 0);
        ula_op: in std_logic_vector(2 downto 0);
        nz: out std_logic_vector(1 downto 0);
        s: out std_logic_vector(7 downto 0)

    );
end entity;

architecture alu_comp of alu_mod is

    component fadderx4 is 
        port(
            a, b : in  std_logic_vector (7 downto 0);
            cin  : in  std_logic;
            s    : out std_logic_vector (7 downto 0);
            cout : out std_logic
        );
    end component;

    signal carry,scout: std_logic;
    signal smux: std_logic_vector(7 downto 0);
    signal snot,sand,sor,sadd: std_logic_vector(7 downto 0);
begin

    -- Not
    snot(7) <= not(a(7));
    snot(6) <= not(a(6));
    snot(5) <= not(a(5));
    snot(4) <= not(a(4));
    snot(3) <= not(a(3));
    snot(2) <= not(a(2));
    snot(1) <= not(a(1));
    snot(0) <= not(a(0));

    -- And
    sand(7) <= a(7) and b(7);
    sand(6) <= a(6) and b(6);
    sand(5) <= a(5) and b(5);
    sand(4) <= a(4) and b(4);
    sand(3) <= a(3) and b(3);
    sand(2) <= a(2) and b(2);
    sand(1) <= a(1) and b(1);
    sand(0) <= a(0) and b(0);

    -- Or
    sor(7) <= a(7) or b(7);
    sor(6) <= a(6) or b(6);
    sor(5) <= a(5) or b(5);
    sor(4) <= a(4) or b(4);
    sor(3) <= a(3) or b(3);
    sor(2) <= a(2) or b(2);
    sor(1) <= a(1) or b(1);
    sor(0) <= a(0) or b(0);

    -- Add
    fadderx4_0: fadderx4 port map(a,b,'0',sadd,scout);

    -- Mux
    smux <= b when ula_op="000"
    else sadd when ula_op = "001"
    else sor  when ula_op = "010"
    else sand when ula_op = "011"
    else snot when ula_op = "100"
    else (others=>'Z');
        

    -- Detector NZ
    nz <= "01" when (smux="00000000")
    else "10" when (smux(7)='1')
    else "00";

    s <= smux;
    
end architecture alu_comp;

