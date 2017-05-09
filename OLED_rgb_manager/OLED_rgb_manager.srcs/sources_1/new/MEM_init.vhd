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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MEM_init is
    Port 
    ( 
        read_idx    : in    STD_LOGIC_VECTOR (4 downto 0);
        data_out    : out   STD_LOGIC_VECTOR (15 downto 0)
    );
end MEM_init;

architecture Behavioral of MEM_init is

    type   MEMORY is array (0 to 29) of std_logic_vector(15 downto 0);
    signal mem          : MEMORY := (
                                        X"FD12",
                                        X"AEA0",
                                        X"72A1",
                                        X"00A2",
                                        X"00A4",
                                        X"A83F",
                                        X"AD8E",
                                        X"B00B",
                                        X"B131",
                                        X"B3F0",
                                        X"8A64",
                                        X"8B78",
                                        X"8C64",
                                        X"BB3A",
                                        X"BE3E",
                                        X"8706",
                                        X"81FF",
                                        X"82FF",
                                        X"83FF",
                                        X"2E25",
                                        X"0000",
                                        X"5F3F",
                                        X"2611",
                                        X"223F",
                                        X"2F5F",
                                        X"3F3E",
                                        X"0000",
                                        X"003F",
                                        X"00E3",
                                        X"E3E3"
                                    );
    signal sdata_out    : std_logic_vector (15 downto 0);
    
begin

    process(read_idx)
        begin
            sdata_out <= mem(to_integer(unsigned(read_idx)));
    end process;
    
    data_out    <= sdata_out;
    
end Behavioral;
