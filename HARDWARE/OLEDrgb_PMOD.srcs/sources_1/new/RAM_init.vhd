----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2017 13:47:39
-- Design Name: 
-- Module Name: MEM_init - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

package ram_config IS
	
	constant MEM_size    : integer := 15;   -- definit la taille du tableau memoire
	constant addr_size   : integer := 4;    -- definit la taille du mot d'adresse de lecture
	constant data_size   : integer := 32;   -- definit la taille des case memoire de la RAM

end;

-------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ram_config.ALL;

entity RAM_init is
    Port 
    ( 
        read_idx    : in    STD_LOGIC_VECTOR (addr_size-1 downto 0);
        data_out    : out   STD_LOGIC_VECTOR (data_size-1 downto 0)
    );
end RAM_init;

architecture Behavioral of RAM_init is

    type   MEMORY is array (0 to MEM_size-1) of std_logic_vector(data_size-1 downto 0);
    signal mem          : MEMORY := (
                                        X"FD12AEA0",
                                        X"72A100A2",
                                        X"00A4A83F",
                                        X"AD8EB00B",
                                        X"B131B3F0",
                                        X"8A648B78",
                                        X"8C64BB3A",
                                        X"BE3E8706",
                                        X"81FF82FF",
                                        X"83FF2E25",
                                        X"00005F3F",
                                        X"26112200",
                                        X"005F3F3E",
                                        X"00000000",
                                        X"3EE3E3E3"
                                    );
    signal sdata_out    : std_logic_vector (data_size-1 downto 0);
    
begin

    process(read_idx)
        begin
            sdata_out <= mem(to_integer(unsigned(read_idx)));
    end process;
    
    data_out    <= sdata_out;
    
end Behavioral;
