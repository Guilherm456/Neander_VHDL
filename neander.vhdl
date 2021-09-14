
library ieee;
use ieee.std_logic_1164.all; 

entity neander is
    port(
        rst : in std_logic;
        clk : in std_logic
    );
end entity;

architecture neander_pc of neander is
    
    component controle is
        port(
            barramento          : in std_logic_vector(7 downto 0);
            interface_flags     : in std_logic_vector(1 downto 0);
            RI_nrw, cl, clk     : in std_logic;
            barramento_controle : out std_logic_vector(10 downto 0)
        );
    end component;

    component ula is
        port(
            barramento              : inout std_logic_vector(7 downto 0);
            ULA_op                  : in std_logic_vector(2 downto 0);
            AC_nrw,MEM_nrw,rst,clk  : in std_logic;
            interface_flags         : out std_logic_vector(1 downto 0)
        );
    end component;

    component mem is
        port(
            barramento                      : inout std_logic_vector(7 downto 0);
            end_PC, end_barr                : in std_logic_vector(7 downto 0);
            barrPC,REM_nrw,MEM_nrw,RDM_nrw  : in std_logic;
            cl, clk                         : in std_logic
        );
    end component;

    component PC is
        port(
            barramento               : in std_logic_vector(7 downto 0);
            barr_INC, PC_nrw, cl, clk : in std_logic;
            endout                   : out std_logic_vector(7 downto 0)
        );
    end component;

    signal barramento           : std_logic_vector(7 downto 0) := (others => 'Z'); 
    signal s_endPC              : std_logic_vector(7 downto 0) := (others => 'Z'); 
    signal flagsNZ              : std_logic_vector(1 downto 0) := (others => 'Z');
    signal s_bctrl              : std_logic_vector(10 downto 0);
begin

    -- ULA
    ula_modulo  : ula port map(barramento,s_bctrl(8 downto 6),s_bctrl(4),s_bctrl(3),rst, clk, flagsNZ);

    -- Memória
    mem_modulo  : mem port map(barramento, s_endPC,barramento, s_bctrl(9), s_bctrl(2), s_bctrl(3), s_bctrl(1), rst, clk);

    -- PC
    pc_modulo   : pc port map(barramento, s_bctrl(10), s_bctrl(5), rst, clk, s_endPC);

    -- UC
    UC_modulo   : controle port map(barramento, flagsNZ, s_bctrl(0), rst, clk, s_bctrl);
    
    
end architecture neander_pc;
