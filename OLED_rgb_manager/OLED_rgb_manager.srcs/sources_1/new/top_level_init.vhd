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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level_init is
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
end top_level_init;

architecture Behavioral of top_level_init is
    signal sCS      : STD_LOGIC;
    signal sMOSI    : STD_LOGIC;
    signal ssclk    : STD_LOGIC;
    signal sDC      : STD_LOGIC;
    signal sRES     : STD_LOGIC;
    signal sVCCEN   : STD_LOGIC;
    signal sPMODEN  : STD_LOGIC;
    
    signal saddress         : STD_LOGIC_VECTOR (12 downto 0);
    signal sw1              : STD_LOGIC;
    signal sdata_in1        : STD_LOGIC_VECTOR (15 downto 0);
    signal sdata_out2       : STD_LOGIC_VECTOR (15 downto 0);
    signal sMISO            : STD_LOGIC;
    signal sread_idx_mem    : STD_LOGIC_VECTOR (4 downto 0);
    signal sread_idx_ram    : STD_LOGIC_VECTOR (12 downto 0);
    signal sdata_en         : STD_LOGIC;
    signal sdata_in         : STD_LOGIC_VECTOR (7 downto 0);
    signal sdata_out_mem    : STD_LOGIC_VECTOR (15 downto 0);
    signal sdata_out_ram    : STD_LOGIC_VECTOR (15 downto 0);
    signal sSPI_busy        : STD_LOGIC;
    
    component line_col_decoder is
        Port
        (
            col     : in  STD_LOGIC_VECTOR (6 downto 0);
            row     : in  STD_LOGIC_VECTOR (5 downto 0);
            address : out STD_LOGIC_VECTOR (12 downto 0)
        );
    end component;
        
    component MEM_init is
        Port 
        (  
            read_idx    : in    STD_LOGIC_VECTOR (4 downto 0);
            data_out    : out   STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    
    component RAM is
        Port 
        ( 
            clk1        : in  STD_LOGIC;
            clk2        : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            w1          : in  STD_LOGIC;
            w2          : in  STD_LOGIC;
            address1    : in  STD_LOGIC_VECTOR (12 downto 0);
            address2    : in  STD_LOGIC_VECTOR (12 downto 0);
            data_in1    : in  STD_LOGIC_VECTOR (15 downto 0);
            data_in2    : in  STD_LOGIC_VECTOR (15 downto 0);
            data_out1   : out STD_LOGIC_VECTOR (15 downto 0);
            data_out2   : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    
--    component RAM_b is
--        Port 
--        ( 
--             clk   : in  std_logic;
--             addr1 : in  std_logic_vector(12 downto 0);
--             din1  : in  std_logic_vector(15 downto 0);
--             w1    : in  std_logic;
--             dout1 : out std_logic_vector(15 downto 0);
--             addr2 : in  std_logic_vector(12 downto 0);
--             din2  : in  std_logic_vector(15 downto 0);
--             w2    : in  std_logic;
--             dout2 : out std_logic_vector(15 downto 0)
--        );
--    end component;
    
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
            clk             : in  STD_LOGIC;
            reset           : in  STD_LOGIC;
            SPI_busy        : in  STD_LOGIC;
            data_in_mem     : in  STD_LOGIC_VECTOR (15 downto 0);
            data_in_ram     : in  STD_LOGIC_VECTOR (15 downto 0);
            data_en         : out STD_LOGIC;
            data_out        : out STD_LOGIC_VECTOR (7 downto 0);
            read_idx_mem    : out STD_LOGIC_VECTOR (4 downto 0);
            read_idx_ram    : out STD_LOGIC_VECTOR (12 downto 0);
            DC              : out STD_LOGIC;
            RES             : out STD_LOGIC;
            VCCEN           : out STD_LOGIC;
            PMODEN          : out STD_LOGIC
        );
    end component;
begin

    bloc0 : line_col_decoder
    Port map
    (
        col     => col,
        row     => row,
        address => saddress
    );
    
    bloc1 : MEM_init 
    Port map
    (
        read_idx    => sread_idx_mem,
        data_out    => sdata_out_mem
    );
    
--    bloc2 : RAM_b
--    Port map
--    (
--         clk    => clk,
--         addr1  => sread_idx_ram,
--         din1   => sdata_in1,
--         w1     => sw1,
--         dout1  => sdata_out_ram,
--         addr2  => address,
--         din2   => data_in,
--         w2     => write_en,
--         dout2  => sdata_out2 
--    );
    
    bloc2 : RAM 
    Port map
    ( 
        clk1        => clk,
        clk2        => clk,
        reset       => reset,
        w1          => sw1,
        w2          => write_en,
        address1    => sread_idx_ram,
        address2    => saddress,
        data_in1    => sdata_in1,
        data_in2    => data_in,
        data_out1   => sdata_out_ram,
        data_out2   => sdata_out2
    );
    
    bloc3 : SPI_controller 
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
    
    bloc4 : FSM 
    Port map
    (
        clk             => clk,
        reset           => reset,
        SPI_busy        => sSPI_busy,
        data_in_mem     => sdata_out_mem,
        data_in_ram     => sdata_out_ram,
        data_en         => sdata_en,
        data_out        => sdata_in,
        read_idx_mem    => sread_idx_mem,
        read_idx_ram    => sread_idx_ram,
        DC              => sDC,
        RES             => sRES,
        VCCEN           => sVCCEN,
        PMODEN          => sPMODEN
    );

    sMISO       <= '0';
    sw1         <= '0';
    sdata_in1   <= std_logic_vector(to_unsigned(0, 16));
    
    process (clk, reset)
        begin
   --         if reset = '1' then
     --           data_out <= std_logic_vector(to_unsigned(0, 16));
       --     else
                if rising_edge(clk) then
                    data_out    <= sdata_out2;
                end if;
         --   end if;
    end process;
    
    CS          <= sCS;
    MOSI        <= sMOSI;
    sclk        <= ssclk;
    DC          <= sDC;
    RES         <= sRES;
    VCCEN       <= sVCCEN;
    PMODEN      <= sPMODEN;

end Behavioral;
