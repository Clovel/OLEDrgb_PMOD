----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2017 12:39:53
-- Design Name: 
-- Module Name: top_level_test - Behavioral
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

entity top_level_test is
    Port 
    ( 
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        button      : in  STD_LOGIC;
        data_out    : out STD_LOGIC_VECTOR (15 downto 0);
        CS          : out STD_LOGIC;
        MOSI        : out STD_LOGIC;   
        sclk        : out STD_LOGIC;
        DC          : out STD_LOGIC;
        RES         : out STD_LOGIC;
        VCCEN       : out STD_LOGIC;
        PMODEN      : out STD_LOGIC
    );
end top_level_test;

architecture Behavioral of top_level_test is

    signal swrite_en    : STD_LOGIC;
    signal scol         : STD_LOGIC_VECTOR (6 downto 0);
    signal srow         : STD_LOGIC_VECTOR (5 downto 0);
    signal sdata_out    : STD_LOGIC_VECTOR (15 downto 0);
    signal sdata_in     : STD_LOGIC_VECTOR (15 downto 0);
    
    signal sCS      : STD_LOGIC;
    signal sMOSI    : STD_LOGIC;
    signal ssclk    : STD_LOGIC;
    signal sDC      : STD_LOGIC;
    signal sRES     : STD_LOGIC;
    signal sVCCEN   : STD_LOGIC;
    signal sPMODEN  : STD_LOGIC;
    
    component top_level_init is
        Port 
        ( 
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            write_en    : in  STD_LOGIC;
            data_in     : in  STD_LOGIC_VECTOR (15 downto 0);
            col         : in  STD_LOGIC_VECTOR (6 downto 0);
            row         : in  STD_LOGIC_VECTOR (5 downto 0);
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
    
    component FSM_test is
        Port 
        (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            button      : in  STD_LOGIC;
            write_en    : out STD_LOGIC;
            col         : out STD_LOGIC_VECTOR (6 downto 0);
            row         : out STD_LOGIC_VECTOR (5 downto 0);
            data_out    : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    
begin

    bloc1 : FSM_test
    Port map
    (
        clk         => clk,
        reset       => reset,
        button      => button,
        write_en    => swrite_en,
        col         => scol,
        row         => srow,
        data_out    => sdata_in
    );
    
    bloc2 : top_level_init
    Port map
    (
        clk         => clk,
        reset       => reset,
        write_en    => swrite_en,
        data_in     => sdata_in,
        col         => scol,
        row         => srow,
        data_out    => open,
        CS          => sCS,
        MOSI        => sMOSI,
        sclk        => ssclk,
        DC          => sDC,
        RES         => sRES,
        VCCEN       => sVCCEN,
        PMODEN      => sPMODEN
    );
    
    data_out    <= x"0000";--sdata_out;
    CS          <= sCS;
    MOSI        <= sMOSI;
    sclk        <= ssclk;
    DC          <= sDC;
    RES         <= sRES;
    VCCEN       <= sVCCEN;
    PMODEN      <= sPMODEN;
    
end Behavioral;
