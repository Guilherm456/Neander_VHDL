-- ghdl -a *.vhdl ; ghdl -r tb_reg_AC --wave=01-tb_reg_AC.ghw --stop-time=300ns
library ieee;
use ieee.std_logic_1164.all; 

entity tb_reg_AC is
    
end entity;

architecture ula_modulo of tb_reg_AC is
    constant cicloClock : time := 20 ns;


    component reg_AC is
    port(
        din : in std_logic_vector(7 downto 0);
        nrw,cl,clk: in std_logic;
        dout: out std_logic_vector(7 downto 0)
    );
    end component;

    signal sdin, sdout: std_logic_vector(7 downto 0);
    signal scl : std_logic := '1';
    signal sclk : std_logic := '0';
    signal snrw: std_logic;
begin
    sclk <= not(sclk) after cicloClock / 2;

    tb_reg: reg_AC port map(sdin,snrw, scl, sclk,sdout);

    u_tb: process
    begin
         -- reset inicial
         scl <= '0';
         wait for cicloClock;
         scl <= '1';

         snrw <= '0';
         sdin <= "00001111";
         wait for cicloClock;

         snrw <= '1';
         sdin <= "11110000";
         wait for cicloClock;

    

        wait;
    end process;
    
end architecture;
