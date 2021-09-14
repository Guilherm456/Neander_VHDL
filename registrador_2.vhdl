library ieee;
use ieee.std_logic_1164.all; 
entity registrador_2 is
    port(
        datain      : in std_logic_vector(1 downto 0);
        nrw,cl,clk  : in std_logic;
        dataout     : out std_logic_vector(1 downto 0)
    );
end entity;

architecture registrador_comp of registrador_2 is
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
    reg : for i in 1 downto 0 generate
        r : ffd port map(datain(i), nrw,clk, '1', cl, dataout(i));
    end generate reg;

end architecture;