-- MARINO Xavier & DURAND Clovis
-- ENSEIRB-Matmeca, E2
-- 2017 - PR214
-- OLEDrgb PMOD

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sync_ram is
	generic (
		data_size	: integer := 16;
		addr_length	: integer := 10
		-- Ave ces valeurs par defaut, on a 2ko, taille de base des blocs memoire du FPGA
		);
  	port (
		clock   : in  std_logic;
		we      : in  std_logic;
		address : in  std_logic_vector (addr_length - 1 downto 0);
		datain  : in  std_logic_vector (data_size - 1 downto 0);
		dataout : out std_logic_vector (data_size - 1 downto 0)
		);
end entity sync_ram;

architecture RTL of sync_ram is

   type ram_type is array (0 to (2**addr_length)-1) of std_logic_vector(data_size - 1 downto 0); ---
   signal ram : ram_type;
   -- signal read_address : std_logic_vector(address'range); --inutile

begin

RamProc: process(clock) is

begin

    if rising_edge(clock) then
        if we = '1' then
            ram(to_integer(unsigned(address))) <= datain;
        end if;
    end if;
    
end process RamProc;

dataout <= ram(to_integer(unsigned(address)));

end architecture RTL;