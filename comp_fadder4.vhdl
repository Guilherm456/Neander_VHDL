library ieee;
use ieee.std_logic_1164.all; 
entity fadderx4 is
    port(
        a, b : in  std_logic_vector (7 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector (7 downto 0);
        cout : out std_logic
    );
end fadderx4;

architecture alu_comp of fadderx4 is
   
component fadderx1 is
    port(
        a, b : in  std_logic;
        cin  : in  std_logic;
        s    : out std_logic;
        cout : out std_logic
    );
end component;

    signal carry: std_logic_vector(7 downto 0);
    begin
        f0 : fadderx1 port map(a(0),b(0),cin, s(0),carry(1));

        f1 : fadderx1 port map(a(1),b(1),carry(1), s(1),carry(2));
        f2 : fadderx1 port map(a(2),b(2),carry(2), s(2),carry(3));
        f3 : fadderx1 port map(a(3),b(3),carry(3), s(3),carry(4));
        f4 : fadderx1 port map(a(4),b(4),carry(4), s(4),carry(5));
        f5 : fadderx1 port map(a(5),b(5),carry(5), s(5),carry(6));
        f6 : fadderx1 port map(a(6),b(6),carry(6), s(6),carry(7));

        f7 : fadderx1 port map(a(7),b(7),carry(7),s(7),cout);


        
end architecture alu_comp;
