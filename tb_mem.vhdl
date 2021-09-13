-- ghdl -a *.vhdl ; ghdl -r tb_mem --wave=tb_mem.ghw --stop-time=300ns

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mem is
end entity;

architecture mem_modulo of tb_mem is
    constant cicloClock : time := 20 ns;

    component mem is
        port(
            barramento                      : inout std_logic_vector(7 downto 0);
            end_PC, end_barr                : in std_logic_vector(7 downto 0);
            barrPC,REM_nrw,MEM_nrw,RDM_nrw  : in std_logic;
            cl, clk                         : in std_logic
        );
    end component;

    signal srst : std_logic := '1';
    signal sclk : std_logic := '0';
    signal sEndPC, sEndBar, sbarramento          : std_logic_vector(7 downto 0);
    signal sNBarPC, sREMrw, sMEMrw, sRDMrw  : std_logic;

begin
    sclk <= not(sclk) after cicloClock / 2;

    u_MEM : mem port map(sbarramento, sendPC, sendbar, sNBarPC,sREMrw, sMEMrw, sRDMrw,srst, sclk);

    tb : process
    begin
        -- reset inicial
        srst <= '0';
        wait for cicloClock;
        srst <= '1';
        
        sNBarPC <= '1';
        sREMrw <= '1';
        sMEMrw <= '0';
        sRDMrw <= '1';

        -- Leitura na posição 0
        sEndPC <= "00000000";
        wait for cicloClock;

        sMEMrw <= '1';
        sbarramento <= "00100000";
        wait for cicloClock;

        wait; -- forever!
    end process;
end architecture;