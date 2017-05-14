----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2017 14:30:53
-- Design Name: 
-- Module Name: tb_top_level_init - Behavioral
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

entity tb_top_level_init is
end tb_top_level_init;

architecture Behavioral of tb_top_level_init is
    component top_level_init
        Port 
        ( 
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            write_en    : in  STD_LOGIC;
            data_in     : in  STD_LOGIC_VECTOR (15 downto 0);
            address     : in  STD_LOGIC_VECTOR (12 downto 0);
            data_out    : out STD_LOGIC_VECTOR (15 downto 0);
            CS          : out STD_LOGIC;
            MOSI        : out STD_LOGIC;   
            sclk        : out STD_LOGIC;
            DC          : out STD_LOGIC;
            RES         : out STD_LOGIC;
            VCCEN       : out STD_LOGIC;
            PMODEN      : out STD_LOGIC
        );
    end component;

    signal ssclk        : STD_LOGIC;
    signal sreset       : STD_LOGIC;
    signal swrite_en    : STD_LOGIC;
    signal sdata_in     : STD_LOGIC_VECTOR (15 downto 0);
    signal saddress     : STD_LOGIC_VECTOR (12 downto 0);
    
begin

    bloc_test : top_level_init 
    Port map
    (
        clk         => ssclk,
        reset       => sreset,
        write_en    => swrite_en,
        data_in     => sdata_in,
        address     => saddress
    );

    clock : process
        begin
            ssclk <= '0';
            wait for 5 ns;
            ssclk <= '1';
            wait for 5 ns;
    end process;
    
    test : process
        begin
            sreset      <= '1';
            swrite_en   <= '0';
            sdata_in    <= std_logic_vector(to_unsigned(0, 16));
            saddress    <= std_logic_vector(to_unsigned(0, 13));
            
            wait for 58 ns;
            
            sreset      <= '0';
            
            wait;
    end process;
    
end Behavioral;
