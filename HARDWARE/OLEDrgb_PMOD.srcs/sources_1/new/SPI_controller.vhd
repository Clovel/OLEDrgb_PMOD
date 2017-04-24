----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2017 10:36:36
-- Design Name: 
-- Module Name: SPI_controller - Behavioral
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

entity SPI_controller is
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
end SPI_controller;

architecture Behavioral of SPI_controller is

    constant    cpt_sclk_max :  natural := 18;

    signal      cpt_sclk    : natural range 0 to cpt_sclk_max;
    signal      cpt_octet   : natural range 0 to 7;
    signal      ssclk       : STD_LOGIC;
    signal      sdata_in    : STD_LOGIC_VECTOR(7 downto 0);
    signal      sMOSI       : STD_LOGIC;
    signal      sSPI_busy   : STD_LOGIC;

begin

    cs <= '0';
    
    sclk_generator : process (clk, reset)
        begin
            if reset = '1' then
                ssclk       <= '0';
                cpt_sclk    <= 0;
                cpt_octet   <= 7;
            else
                if rising_edge(clk) then
                
                    if cpt_sclk = 0 then
                    
                        if data_en = '1' then
                            ssclk       <= '1';
                            cpt_sclk    <= cpt_sclk + 1;
                            cpt_octet   <= 0;
                        elsif cpt_octet /= 7 then
                            ssclk       <= '1';
                            cpt_sclk    <= cpt_sclk + 1;
                            cpt_octet   <= cpt_octet +1;
                        else 
                            ssclk <= '0';
                            cpt_sclk     <= cpt_sclk;
                        end if;
                      
                    else
                        if cpt_sclk < 9 then
                            ssclk       <= '1';
                            cpt_sclk    <= cpt_sclk + 1;
                        elsif cpt_sclk = (cpt_sclk_max - 1) then
                            ssclk       <= '0';
                            cpt_sclk    <= 0;
                        else
                            ssclk <= '0';
                            cpt_sclk    <= cpt_sclk + 1;
                        end if;
                        
                    end if;
                    
                end if;
            end if;
    end process;
    
    sclk <= NOT(ssclk);
    
    SPI_busy_generator : process(clk, reset)
        begin
            if reset = '1' then
                sSPI_busy <= '0';
            else
                if rising_edge(clk) then
                    if data_en = '1' then
                        sSPI_busy <= '1';
                    else
                        if cpt_octet = 7 then
                            if cpt_sclk = 17 then
                                sSPI_busy <= '0';
                            end if;
                        end if;
                    end if;
                end if;
            end if;
    end process;
                        
    SPI_busy <= sSPI_busy;
                    
    data_in_save : process(clk, reset)
        begin
            if reset = '1' then
                sdata_in <= "00000000";
            else
                if rising_edge(clk) then
                    if data_en = '1' then
                        sdata_in <= data_in;
                    else
                        if ssclk = '1' then
                            if cpt_sclk = 1 then
                                sdata_in <= sdata_in (6 downto 0) & sdata_in (7 downto 7);
                            else
                                sdata_in <= sdata_in;
                            end if;
                        else
                            sdata_in <= sdata_in;
                        end if;
                    end if;
                end if;
            end if;
    end process;
    
    data_sending : process(clk, reset)
        begin
            if reset = '1' then
                sMOSI <= '0';
            else
                if rising_edge(clk) then
                    if ssclk = '1' then
                        if cpt_sclk = 1 then
                            sMOSI <= sdata_in (7);
                        else
                            sMOSI <= sMOSI;
                        end if;
                    else 
                        if sSPI_busy = '0' then
                            sMOSI <= '0';
                        else
                            sMOSI <= sMOSI;
                        end if;
                    end if;
                end if;
            end if;
    end process;
    
    MOSI <= sMOSI;

end Behavioral;
