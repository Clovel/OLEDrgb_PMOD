----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2017 10:20:13
-- Design Name: 
-- Module Name: tb_SPI_controller - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_SPI_controller is
end tb_SPI_controller;

architecture Behavioral of tb_SPI_controller is

component SPI_controller

    Port 
    (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;     
        data_en     : in  STD_LOGIC;
        data_in     : in  STD_LOGIC_VECTOR (7 downto 0);
        sclk        : out STD_LOGIC;
        cs          : out STD_LOGIC;
        MOSI        : out STD_LOGIC;
        SPI_busy    : out STD_LOGIC;
        MISO        : in  STD_LOGIC
    );
    
end component;

    signal sclk     : STD_LOGIC;
    signal sreset   : STD_LOGIC;
    signal sdata_en : STD_LOGIC;
    signal sdata_in : STD_LOGIC_VECTOR (7 downto 0);
    signal sMISO    : STD_LOGIC;

begin

    bloc1 : SPI_controller
    Port map
    (
        clk     => sclk,
        reset   => sreset,
        data_en => sdata_en,
        data_in => sdata_in,
        MISO    => sMISO
    );
    
    clock : process
    
        begin
    
            sclk <= '0';
            wait for 5 ns;
            sclk <= '1';
            wait for 5 ns;
        
    end process;
    
    test : process
     
        begin
        
            sreset      <= '1';
            sdata_en    <= '0';
            sdata_in    <= "00000000";
            sMISO       <= '0';
            
            wait for 58 ns;
            
            sreset      <= '0';
            
            wait for 19 ns;
            
            sdata_en    <= '1';
            sdata_in    <= "10101010";
            
            wait for 10 ns;
            
            sdata_en    <= '0';
            
            wait for 3000 ns;
            
            sdata_en    <= '1';
            sdata_in    <= "00101101";
            
            wait for 10 ns;
            
            sdata_en    <= '0'; 
            
            wait;           
    end process;

end Behavioral;
