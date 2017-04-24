----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2017 14:00:43
-- Design Name: 
-- Module Name: top_level_init - Behavioral
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

entity top_level_init is
    Port 
    ( 
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        CS      : out STD_LOGIC;
        MOSI    : out STD_LOGIC;   
        sclk    : out STD_LOGIC;
        DC      : out STD_LOGIC;
        RES     : out STD_LOGIC;
        VCCEN   : out STD_LOGIC;
        PMODEN  : out STD_LOGIC
    );
end top_level_init;

architecture Behavioral of top_level_init is
    signal sCS      : STD_LOGIC;
    signal sMOSI    : STD_LOGIC;
    signal ssclk    : STD_LOGIC;
    signal sDC      : STD_LOGIC;
    signal sRES     : STD_LOGIC;
    signal sVCCEN   : STD_LOGIC;
    signal sPMODEN  : STD_LOGIC;
    
    signal sMISO        : STD_LOGIC;
    signal sread_idx    : STD_LOGIC_VECTOR (3 downto 0);
    signal sdata_en     : STD_LOGIC;
    signal sdata_in     : STD_LOGIC_VECTOR (7 downto 0);
    signal sdata_out    : STD_LOGIC_VECTOR (31 downto 0);
    signal sSPI_busy    : STD_LOGIC;
    
    component MEM_init is
        Port 
        (  
            read_idx    : in    STD_LOGIC_VECTOR (3 downto 0);
            data_out    : out   STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;
    
    component SPI_controller is
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
    
    component FSM is
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
begin

    bloc1 : MEM_init 
    Port map
    (
        read_idx    => sread_idx,
        data_out    => sdata_out
    );
    
    bloc2 : SPI_controller 
    Port map
    (
        clk         => clk,
        reset       => reset,    
        data_en     => sdata_en,
        data_in     => sdata_in,
        sclk        => ssclk,
        cs          => sCS,
        MOSI        => sMOSI,
        SPI_busy    => sSPI_busy,
        MISO        => sMISO
    );
    
    bloc3 : FSM 
    Port map
    (
        clk         => clk,
        reset       => reset,
        SPI_busy    => sSPI_busy,
        data_in     => sdata_out,
        data_en     => sdata_en,
        data_out    => sdata_in,
        read_idx    => sread_idx,
        DC          => sDC,
        RES         => sRES,
        VCCEN       => sVCCEN,
        PMODEN      => sPMODEN
    );

    sMISO   <= '0';
    
    CS      <= sCS;
    MOSI    <= sMOSI;
    sclk    <= ssclk;
    DC      <= sDC;
    RES     <= sRES;
    VCCEN   <= sVCCEN;
    PMODEN  <= sPMODEN;

end Behavioral;
