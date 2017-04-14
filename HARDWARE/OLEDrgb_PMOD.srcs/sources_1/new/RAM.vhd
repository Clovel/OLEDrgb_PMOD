-- MARINO Xavier & DURAND Clovis
-- ENSEIRB-Matmeca, E2
-- 2017 - PR214
-- OLEDrgb PMOD

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sync_ram is
	generic (
		data_size	: integer;
		ram_length	: integer
		);
  	port (
		clock   : in  std_logic;
		we      : in  std_logic;
		address : in  std_logic_vector;
		datain  : in  std_logic_vector;
		dataout : out std_logic_vector
		);
end entity sync_ram;

architecture RTL of sync_ram is

   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(datain'range); ---
   signal ram : ram_type;
   -- signal read_address : std_logic_vector(address'range); --inutile

begin

RamProc: process(clock) is

begin

    if rising_edge(clock) then
        if we = '1' then
            ram(to_integer(unsigned(address))) <= datain;
        end if;
        read_address <= address;
    end if;
    
end process RamProc;

dataout <= ram(to_integer(unsigned(address)));

end architecture RTL;