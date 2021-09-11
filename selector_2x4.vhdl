library ieee;
use ieee.std_logic_1164.all; 

entity selector_2x4 is
    port(
        c0,c1 	: in std_logic_vector(3 downto 0);
        cin0,cin1 : in std_logic;
        s	: out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end entity;

architecture alu_comp of selector_2x4 is
    signal sel : std_logic;
begin
    sel <= cin0 or (not(cin0) and ((c0(3) and c0(2)) or (c0(3) and c0(1))));
    -- cout <= cin0 or (not(cin0) and ((c0(3) and c0(2)) or (c0(3) and c0(1))));
    
    cout <= sel;
    s <= c0 when sel = '0' else c1;
end architecture alu_comp;