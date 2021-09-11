library ieee;
use ieee.std_logic_1164.all; 
entity fadderx1 is
    port(
        a, b : in  std_logic;
        cin  : in  std_logic;
        s    : out std_logic;
        cout : out std_logic
    );
end fadderx1;

architecture alu_comp of fadderx1 is
begin   
    s    <= (a xor b) xor cin;
    cout <= (a and cin) or (b and cin) or (a and b);
end architecture alu_comp;
