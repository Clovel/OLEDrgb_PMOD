----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2017 12:31:19
-- Design Name: 
-- Module Name: FSM_test - Behavioral
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

entity FSM_test is
    Port 
    (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        button      : in  STD_LOGIC;
        write_en    : out STD_LOGIC;
        address     : out STD_LOGIC_VECTOR (12 downto 0);
        data_out    : out STD_LOGIC_VECTOR (15 downto 0)
    );
end FSM_test;

architecture Behavioral of FSM_test is

    signal swrite_en    : STD_LOGIC;
    signal saddress     : UNSIGNED (12 downto 0);
    signal sdata_out    : STD_LOGIC_VECTOR (15 downto 0);

begin
    
    process(button)
        begin
            swrite_en <= button;
    end process;
    
    write_en <= swrite_en;
    
    sdata_out <= X"f800";
    data_out  <= sdata_out;
    
    process(clk, reset)
        begin
            if reset = '1' then
                saddress <= to_unsigned(0, 13);
            else
                if rising_edge(clk) then
                    if saddress = to_unsigned(6143, 13) then
                        saddress <= to_unsigned(0, 13);
                    else
                        saddress <= saddress + 1;
                    end if;
                end if;
            end if;
    end process;             
    
    address <= std_logic_vector(saddress);

end Behavioral;
