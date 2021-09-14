library ieee;
use ieee.std_logic_1164.all; 

entity PC is
    port(
        barramento               : in std_logic_vector(7 downto 0);
        barr_INC, PC_nrw, cl, clk : in std_logic;
        endout                   : out std_logic_vector(7 downto 0)
    );
end entity;

architecture PC_modulo of PC is
    component fadderx4 is 
        port(
            a, b : in  std_logic_vector (7 downto 0);
            cin  : in  std_logic;
            s    : out std_logic_vector (7 downto 0);
            cout : out std_logic
        );
    end component;

    component registrador_8 is
        port(
            datain      : in std_logic_vector(7 downto 0);
            nrw,cl,clk  : in std_logic;
            dataout     : out std_logic_vector(7 downto 0)
        );
    end component;

    signal addin : std_logic_vector(7 downto 0);
    signal carry : std_logic;
    signal sadd, s_mux2pc, s_PCatual : std_logic_vector(7 downto 0);
begin
    -- ADD
    fadderx4_0 :  fadderx4 port map("00000001",s_PCatual,'0',sadd,carry);

    -- MUX (add e barramento)
    s_mux2pc <= barramento when barr_INC='0' else sadd;

    -- PC_reg
    PC_reg : registrador_8 port map(s_mux2pc,PC_nrw,cl,clk,s_PCatual);

    endout <= s_PCatual;
    

end architecture;
