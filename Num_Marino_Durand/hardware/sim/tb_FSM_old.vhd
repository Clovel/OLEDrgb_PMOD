----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2017 19:21:31
-- Design Name: 
-- Module Name: tb_FSM - Behavioral
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

entity tb_FSM is
end tb_FSM;

architecture Behavioral of tb_FSM is
    component FSM
        Port
        (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            SPI_busy    : in  STD_LOGIC;
            data_in     : in  STD_LOGIC_VECTOR (31 downto 0);
            data_en     : out STD_LOGIC;
            data_out    : out STD_LOGIC_VECTOR (7 downto 0);
            read_idx    : out STD_LOGIC_VECTOR (3 downto 0);
            DC          : out STD_LOGIC;
            RES         : out STD_LOGIC;
            VCCEN       : out STD_LOGIC;
            PMODEN      : out STD_LOGIC
        );
    end component;
        
    signal sclk         : STD_LOGIC;
    signal sreset       : STD_LOGIC;
    signal sSPI_busy    : STD_LOGIC;
    signal sdata_in     : STD_LOGIC_VECTOR (31 downto 0);
    
begin

    bloc1 : FSM
    Port map
    (
        clk         => sclk,
        reset       => sreset,
        SPI_busy    => sSPI_busy,
        data_in     => sdata_in
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
            sSPI_busy   <= '0';
            sdata_in    <= X"FFF000AA";
            
            wait for 58 ns;
            
            sreset      <= '0';
            
            wait for 457 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
                        
            wait for 20 ns;
            
            sSPI_busy   <= '1';
                        
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                        
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
                                    
            sSPI_busy   <= '0';
            
            wait for 20 ns;
            
            sSPI_busy   <= '1';
            
            wait for 100 ns;
            
            sSPI_busy   <= '0';
            
            wait;
    end process;
    
end Behavioral;
