library ieee;
use ieee.std_logic_1164.all; 

entity controle is
    port(
        barramento          : in std_logic_vector(7 downto 0);
        interface_flags     : in std_logic_vector(1 downto 0);
        RI_nrw, cl, clk     : in std_logic;
        barramento_controle : out std_logic_vector(10 downto 0)
    );
end entity;

architecture controle_modulo of controle is
    
    component registrador_8 is
        port(
            datain      : in std_logic_vector(7 downto 0);
            nrw,cl,clk  : in std_logic;
            dataout     : out std_logic_vector(7 downto 0)
        );
    end component;

    component decode is
        port(
            instrin : in std_logic_vector(7 downto 0);
            instrout: out std_logic_vector(10 downto 0)
        );
    end component;

    component UC is
        port(
            dec2uc              : in std_logic_vector(10 downto 0);
            NZ                  : in std_logic_vector(1 downto 0);
            cl, clk             : in std_logic;
            barramento_controle : out std_logic_vector(10 downto 0)
        );
    end component;

    signal RI2decode : std_logic_vector(7 downto 0);
    signal decode2UC : std_logic_vector(10 downto 0);
begin
    -- RI
    RI_reg : registrador_8 port map(barramento,RI_nrw,cl,clk,RI2decode);

    -- Decodificador
    dec : decode port map(RI2decode,decode2UC);

    -- UC
    uc_comp : UC port map(decode2uc, interface_flags,cl,clk,barramento_controle);
    
    
end architecture controle_modulo;
