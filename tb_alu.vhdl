-- ghdl -a *.vhdl ; ghdl -r tb_alu --wave=tb_alu.ghw --stop-time=300ns

library ieee;
use ieee.std_logic_1164.all; 

entity tb_alu is
    
end entity;

architecture alu_comp of tb_alu is

    component alu_mod is
    port(
        a,b: in std_logic_vector(7 downto 0);
        ula_op: in std_logic_vector(2 downto 0);
        nz: out std_logic_vector(1 downto 0);
        s: out std_logic_vector(7 downto 0)
    );
    end component;

    signal sa,sb,ss : std_logic_vector(7 downto 0);
    signal sula_op : std_logic_vector(2 downto 0);
    signal snz : std_logic_vector(1 downto 0);
begin


    alu_0 : alu_mod port map (sa,sb,sula_op,snz,ss);
    u_tb: process
    begin
         sa <= "01010101";
         sb <= "10101010";
         sula_op <= "001";
         wait for 10 ns;

        wait;
    end process u_tb;
    
end architecture;
