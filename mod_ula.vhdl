library ieee;
use ieee.std_logic_1164.all; 

entity ula is
    port(
        barramento: inout std_logic_vector(7 downto 0);
        ULA_op: in std_logic_vector(2 downto 0);
        AC_rw,MEM_rw,rst,clk: in std_logic;
        interface_flags: out std_logic_vector(1 downto 0)
    );
end entity;

architecture ula_modulo of ula is
    component alu_mod is
    port(
        a,b: in std_logic_vector(7 downto 0);
        ula_op: in std_logic_vector(2 downto 0);
        nz: out std_logic_vector(1 downto 0);
        s: out std_logic_vector(7 downto 0)
    );
    end component;

    component reg_AC is
        port(
            din : in std_logic_vector(7 downto 0);
            nrw,cl,clk: in std_logic;
            dout: out std_logic_vector(7 downto 0)
        );
    end component;

    component reg_FLAGS is
        port(
            din : in std_logic_vector(1 downto 0);
            nrw,cl,clk: in std_logic;
            dout: out std_logic_vector(1 downto 0)
        );
    end component;

    signal s_ac2ula,s_ula2ac: std_logic_vector(7 downto 0);
    signal s_ac2flags: std_logic_vector(1 downto 0);
begin

    -- AC
    regAC : reg_AC port map(s_ula2ac,AC_rw,rst,clk,s_ac2ula);

    -- ULA
    ALU : alu_mod port map(s_ac2ula, barramento,ULA_op,s_ac2flags,s_ula2ac);

    -- FLAGS
    regFLAGS: reg_FLAGS port map(s_ac2flags,AC_rw,rst,clk, interface_flags);

    -- Mux 
    barramento <= s_ac2ula when MEM_rw='1' else (others => 'Z');

    
    
end architecture ula_modulo;
