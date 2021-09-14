-- ghdl -a *.vhdl ; ghdl -r tb_decode --wave=tb_decode.ghw --stop-time=100ns

library ieee;
use ieee.std_logic_1164.all; 

entity tb_decode is
    
end entity;

architecture controle_modulo of tb_decode is
    component decode is
        port(
            instrin : in std_logic_vector(7 downto 0);
            instrout: out std_logic_vector(10 downto 0)
        );
    end component;

    signal sinstrin : std_logic_vector(7 downto 0);
    signal sinstrout : std_logic_vector(10 downto 0);
begin
    
    tb_dec: decode port map(sinstrin,sinstrout);
    u_tb : process 
    begin
        sinstrin <= "00000000";
        wait for 10 ns;
        sinstrin <= "00010000";
        wait for 10 ns;
        sinstrin <= "00100000";
        wait for 10 ns;
        sinstrin <= "00110000";
        wait for 10 ns; 
        sinstrin <= "01000000";
        wait for 10 ns;
        sinstrin <= "01010000";
        wait for 10 ns;
        sinstrin <= "01100000";
        wait for 10 ns;
        sinstrin <= "10000000";
        wait for 10 ns;
        sinstrin <= "10010000";
        wait for 10 ns;
        sinstrin <= "10100000";
        wait for 10 ns;
        sinstrin <= "11110000";
        wait for 10 ns;

        wait; 
    end process;
    
end architecture;
