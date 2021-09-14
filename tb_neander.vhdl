-- ghdl -a *.vhdl ; ghdl -r tb_neander --wave=tb_neander.ghw --stop-time=1000ns
library ieee;
use ieee.std_logic_1164.all; 

entity tb_neander is
    
end entity;

architecture neander_pc of tb_neander is
    constant cicloClock : time := 20 ns;


    component neander is
    port(
        rst : in std_logic;
        clk : in std_logic
    );
    end component;
    

    signal srst : std_logic := '1';
    signal sclk : std_logic := '0';
begin
    sclk <= not(sclk) after cicloClock / 2;

    u_neander : neander port map(srst, sclk);

    u_tb: process
    begin
         -- reset inicial
        srst <= '0';
        wait for cicloClock;
        srst <= '1';

        
        wait;
    end process;
    
end architecture;
