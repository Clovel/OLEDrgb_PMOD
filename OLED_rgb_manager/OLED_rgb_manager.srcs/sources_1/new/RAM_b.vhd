----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2017 11:10:25
-- Design Name: 
-- Module Name: RAM_b - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_b is
  Port ( clk   : in  std_logic;
         addr1 : in  std_logic_vector(12 downto 0);
         din1  : in  std_logic_vector(15 downto 0);
         w1    : in  std_logic;
         dout1 : out std_logic_vector(15 downto 0);
         addr2 : in  std_logic_vector(12 downto 0);
         din2  : in  std_logic_vector(15 downto 0);
         w2    : in  std_logic;
         dout2 : out std_logic_vector(15 downto 0)
          );
end RAM_b;

architecture Behavioral of RAM_b is

type   tRAM is array(0 to 2**13-1) of std_logic_vector(15 downto 0);
signal RAM  : tRAM;

signal a1, a2   : integer range 0 to 2**13-1;
signal di1, di2 : std_logic_vector(15 downto 0);



begin

   process(clk)
   begin
      if rising_edge(clk) then
         --a1 <= to_integer(unsigned(addr1));
         --a2 <= to_integer(unsigned(addr2));
         --di1 <= din1;
         --di2 <= din2;
         --if w1 = '1' then
         --    RAM(a1) <= di1;
         --end if;
         if w2 = '1' then
             RAM(to_integer(unsigned(addr2))) <= din2;
         end if;
         dout1 <= RAM(to_integer(unsigned(addr1)));
         dout2 <= RAM(to_integer(unsigned(addr2)));
      end if;
   end process;



end Behavioral;
