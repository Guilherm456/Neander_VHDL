-- ghdl -a *.vhdl ; ghdl -r tb_ula --wave=tb_ula.ghw --stop-time=440ns
library ieee;
use ieee.std_logic_1164.all; 

entity tb_ula is
    
end entity;

architecture ula_modulo of tb_ula is
    constant cicloClock : time := 20 ns;


    component ula is
    port(
        barramento: inout std_logic_vector(7 downto 0);
        ULA_op: in std_logic_vector(2 downto 0);
        AC_rw,MEM_rw,rst,clk: in std_logic;
        interface_flags: out std_logic_vector(1 downto 0)
    );
    end component;
    

    signal sbarramento: std_logic_vector(7 downto 0);
    signal sula_op: std_logic_vector(2 downto 0);
    signal sAC_nrw, smem_nrw : std_logic;
    signal srst : std_logic := '1';
    signal sclk : std_logic := '0';
    signal sinterface_flags : std_logic_vector(1 downto 0);
begin
    sclk <= not(sclk) after cicloClock / 2;

    tb_ula0: ula port map(sbarramento, sula_op,sAC_nrw,smem_nrw,srst,sclk,sinterface_flags);

    u_tb: process
    begin
         -- reset inicial
        srst <= '0';
        wait for cicloClock;
        srst <= '1';

        -- TESTE 1.
        sbarramento <= "01010101";  -- sy = 85 d
        sAC_nrw     <= '1';
        sMEM_nrw    <= '0';
        sULA_op     <= "000";       
        wait for cicloClock;

        sULA_op     <= "001";
        sbarramento <= "10101010";  -- sy = -86 d
        wait for cicloClock;

        sAC_nrw     <= '1';
        sULA_op     <= "000";
        sbarramento <= "00000001";
        wait for cicloClock;

        sULA_op     <= "010";
        sbarramento <= "10000000";
        wait for cicloClock;

        sULA_op     <= "011";
        wait for cicloClock;

        sULA_op     <= "100";
        wait for cicloClock;


        

        

        wait;
    end process;
    
end architecture;
