----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2017 16:16:09
-- Design Name: 
-- Module Name: line_col_decoder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity line_col_decoder is
    Port 
    (
        col     : in  STD_LOGIC_VECTOR (6 downto 0);
        row     : in  STD_LOGIC_VECTOR (5 downto 0);
        address : out STD_LOGIC_VECTOR (12 downto 0)
     );
end line_col_decoder;

architecture Behavioral of line_col_decoder is
    
    signal saddress : UNSIGNED (12 downto 0);
--    signal scol     : UNSIGNED (12 downto 0);
--    signal srow     : UNSIGNED (12 downto 0);

begin

    process(col, row)
        begin
            saddress <= to_unsigned((to_integer(unsigned(col)) + 96*to_integer(unsigned(row))), 13);
    end process;
    
    address <= std_logic_vector(saddress);

end Behavioral;
