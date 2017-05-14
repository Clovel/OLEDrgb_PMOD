----------------------------------------------------------------------------------
-- Xavier Marino & Clovis Durand
-- 
-- Create Date: 07.05.2017 12:31:19
-- Module Name: FSM_test - Behavioral
-- Project Name: Pmod OLEDrgb Manager
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_test is
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
end FSM_test;

architecture Behavioral of FSM_test is

    signal swrite_en    : STD_LOGIC;
    signal scol         : UNSIGNED (6 downto 0);
    signal srow         : UNSIGNED (5 downto 0);
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
                scol <= to_unsigned(0, 7);
                srow <= to_unsigned(0,6);
            else
                if rising_edge(clk) then
                    if scol = to_unsigned(95, 7) then
                        scol <= to_unsigned(0, 7);
                        if srow = to_unsigned(63, 6) then
                            srow <= to_unsigned(0, 6);
                        else
                            srow <= srow + 1;
                        end if;
                    else
                        scol <= scol + 1;
                    end if;
                end if;
            end if;
    end process;             
    
    col <= std_logic_vector(scol);
    row <= std_logic_vector(srow);

end Behavioral;
