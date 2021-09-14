library ieee;
use ieee.std_logic_1164.all;

entity contador is
    port (
            clk, cl: in std_logic;
            v   : out std_logic_vector(2 downto 0)
        );
end contador;

architecture UC_comp of contador is

    component ffjk is
    port(
        j, k   : in std_logic;
        clk    : in std_logic;
        pr, cl : in std_logic;
        q, nq  : out std_logic
    );
    end component;

    component ctrljk5 is
    port(
        ea   : in  std_logic_vector(2 downto 0);
        j, k : out std_logic_vector(2 downto 0)
    );
    end component;

    signal sv : std_logic_vector(2 downto 0);
    signal sj, sk : std_logic_vector(2 downto 0);
    signal ssj, ssk : std_logic_vector(2 downto 0);

    begin

    v <= sv;

    gerador: for i in 0 to 2 generate 
        --instancia gerador
        ff: ffjk port map(sj(i), sk(i), clk, '1', cl, sv(i));
        
        -- sinal enable!
        sj(i) <= ssj(i);
        sk(i) <= ssk(i);
    end generate gerador;

    -- CTRL JKs como componente instanciado
    uctrljk : ctrljk5 port map(sv, ssj, ssk);

end architecture;

library ieee;
use ieee.std_logic_1164.all; 

entity ctrljk5 is
    port(
        ea   : in  std_logic_vector(2 downto 0);
        j, k : out std_logic_vector(2 downto 0)
    );
end entity;

architecture control of ctrljk5 is

begin

    --j2 k2
    j(2) <= ea(1) and ea(0);
    k(2) <= ea(1) and ea(0);

    -- j1 k1
    j(1) <= ea(0);
    k(1) <= ea(0);

    -- j0 k0
    j(0) <= '1';
    k(0) <= '1';

end architecture;