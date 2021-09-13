library ieee;
use ieee.std_logic_1164.all; 

entity reg_REM is
    port(
        endin       : in std_logic_vector(7 downto 0);
        nrw,cl,clk  : in std_logic;
        endout      : out std_logic_vector(7 downto 0)

    );
end entity;

architecture mem_modulo of reg_REM is
    component ffd is
        port(
            d      : in std_logic;
            nrw    : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

begin
    reg : for i in 7 downto 0 generate
        r : ffd port map(endin(i), nrw,clk, '1', cl, endout(i));
    end generate reg;

end architecture;
