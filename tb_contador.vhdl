-- ghdl -a *.vhdl ; ghdl -r tb_contador --wave=tb_contador.ghw --stop-time=300ns

library ieee;
use ieee.std_logic_1164.all; 

entity tb_contador is
    
end entity;

architecture UC_comp of tb_contador is
    constant cicloClock : time := 20 ns;


    component contador is
    port(
        clk, cl: in std_logic;
        v   : out std_logic_vector(2 downto 0)
    );
    end component;

    signal srst : std_logic := '1';
    signal sclk : std_logic := '0';
    signal senable : std_logic;
    signal sv   : std_logic_vector(2 downto 0);
begin
    sclk <= not(sclk) after cicloClock / 2;

    contador_tb : contador port map (sclk,srst,sv);
    u_tb: process
    begin
         -- reset inicial
         srst <= '0';
         wait for cicloClock;
         srst <= '1'; 


        wait;
    end process u_tb;
    
end architecture;
