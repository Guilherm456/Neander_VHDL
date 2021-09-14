library ieee;
use ieee.std_logic_1164.all; 

entity ula is
    port(
        barramento              : inout std_logic_vector(7 downto 0);
        ULA_op                  : in std_logic_vector(2 downto 0);
        AC_nrw,MEM_nrw,rst,clk    : in std_logic;
        interface_flags         : out std_logic_vector(1 downto 0)
    );
end entity;

architecture ula_modulo of ula is
    component alu_mod is
    port(
        a,b     : in std_logic_vector(7 downto 0);
        ula_op  : in std_logic_vector(2 downto 0);
        nz      : out std_logic_vector(1 downto 0);
        s       : out std_logic_vector(7 downto 0)
    );
    end component;

    component registrador_8 is
        port(
            datain      : in std_logic_vector(7 downto 0);
            nrw,cl,clk  : in std_logic;
            dataout     : out std_logic_vector(7 downto 0)
        );
    end component;

    component registrador_2 is
        port(
            datain      : in std_logic_vector(1 downto 0);
            nrw,cl,clk  : in std_logic;
            dataout     : out std_logic_vector(1 downto 0)
        );
    end component;


    signal s_ac2ula,s_ula2ac: std_logic_vector(7 downto 0);
    signal s_ac2flags: std_logic_vector(1 downto 0);
begin

    -- AC
    AC_reg : registrador_8 port map(s_ula2ac,AC_nrw,rst,clk,s_ac2ula);

    -- ULA
    ALU : alu_mod port map(s_ac2ula, barramento,ULA_op,s_ac2flags,s_ula2ac);

    -- FLAGS
    FLAGS_reg: registrador_2 port map(s_ac2flags,AC_nrw,rst,clk, interface_flags);

    -- Mux 
    barramento <= s_ac2ula when MEM_nrw='1' else (others => 'Z');

    
    
end architecture ula_modulo;
