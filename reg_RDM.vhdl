library ieee;
use ieee.std_logic_1164.all; 

entity reg_RDM is
    port(
        datain      : in std_logic_vector(7 downto 0);
        nrw,cl,clk  : in std_logic;
        dataout     : out std_logic_vector(7 downto 0)
    );
end entity;

architecture mem_modulo of reg_RDM is
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
        r : ffd port map(datain(i), nrw,clk, '1', cl, dataout(i));
    end generate reg;

end architecture;
