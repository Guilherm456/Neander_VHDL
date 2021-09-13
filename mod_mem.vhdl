library ieee;
use ieee.std_logic_1164.all; 

entity mem is
    port(
        barramento                      : inout std_logic_vector(7 downto 0);
        end_PC, end_barr                : in std_logic_vector(7 downto 0);
        barrPC,REM_nrw,MEM_nrw,RDM_nrw  : in std_logic;
        cl, clk                         : in std_logic
    );
end entity;

architecture mem_modulo of mem is

    component reg_REM is
        port(
            endin           : in std_logic_vector(7 downto 0);
            nrw, cl, clk    : in std_logic;
            endout          : out std_logic_vector(7 downto 0)
        );
    end component;

    component reg_RDM is
        port(            
            datain      : in std_logic_vector(7 downto 0);
            nrw,cl,clk  : in std_logic;
            dataout     : out std_logic_vector(7 downto 0)
        );
    end component;
   
    component as_ram is
        port(
            addr  : in    std_logic_vector(7 downto 0);
            data  : inout std_logic_vector(7 downto 0);
            notrw : in    std_logic;
            reset : in    std_logic
        );
    end component;

    signal s_mux2rem, s_rem2mem, s_mem2rdm, s_rdm2barramento : std_logic_vector(7 downto 0);
begin

    -- MUX (normal)
    s_mux2rem <= end_PC when barrPC='1' else end_barr;
    
    -- REM
    regREM : reg_REM port map (s_mux2rem,REM_nrw,cl, clk, s_rem2mem);

    -- MUX (especial)
    barramento <= s_rdm2barramento when MEM_nrw = '0' else (others => 'Z');
    s_mem2rdm <= barramento when MEM_nrw = '1' else (others => 'Z');

    -- MEM
    RAM : as_ram port map(s_rem2mem,s_mem2rdm, MEM_nrw, cl);

    -- RDM
    RDM : reg_RDM port map(s_mem2rdm, RDM_nrw,cl, clk, s_rdm2barramento);

    
end architecture mem_modulo;
