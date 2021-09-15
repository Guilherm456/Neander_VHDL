library ieee;
use ieee.std_logic_1164.all; 

entity decode is
    port(
        instrin : in std_logic_vector(7 downto 0);
        instrout: out std_logic_vector(10 downto 0)
    );
end entity;

architecture controle_modulo of decode is
    
begin
    instrOut(10) <= (((not instrIn(7) and not instrIn(6)) and not instrIn(5)) and not instrIn(4));
    instrOut(9) <= (((not instrIn(7) and not instrIn(6)) and not instrIn(5)) and instrIn(4));
    instrOut(8) <= (((not instrIn(7) and not instrIn(6)) and instrIn(5)) and not instrIn(4));
    instrOut(7) <= (((not instrIn(7) and not instrIn(6)) and instrIn(5)) and instrIn(4));
    instrOut(6) <= (((not instrIn(7) and instrIn(6)) and not instrIn(5)) and not instrIn(4));
    instrOut(5) <= (((not instrIn(7) and instrIn(6)) and not instrIn(5)) and instrIn(4));
    instrOut(4) <= (((not instrIn(7) and instrIn(6)) and instrIn(5)) and not instrIn(4));
    instrOut(3) <= (((instrIn(7) and not instrIn(6)) and not instrIn(5)) and not instrIn(4));
    instrOut(2) <= (((instrIn(7) and not instrIn(6)) and not instrIn(5)) and instrIn(4));
    instrOut(1) <= (((instrIn(7) and not instrIn(6)) and instrIn(5)) and not instrIn(4));
    instrOut(0) <= (((instrIn(7) and instrIn(6)) and instrIn(5)) and instrIn(4));
    
end architecture controle_modulo;
