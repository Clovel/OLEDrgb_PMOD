-- MARINO Xavier & DURAND Clovis
-- ENSEIRB-Matmeca, E2
-- 2017 - PR214
-- OLEDrgb PMOD

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
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
end FSM;

architecture Behavioral of FSM is

    constant    cpt_150ms_max   : NATURAL := 15000000;
    constant    cpt_15us_max    : NATURAL := 1500;
    constant    cpt_500ms_max   : NATURAL := 50000000;
    constant    read_idx_init   : NATURAL := 10;
    constant    read_idx_rec    : NATURAL := 14;
    constant    cpt_read_max    : NATURAL := 3;
    
    signal      cpt_150ms       : NATURAL range 0 to cpt_150ms_max;
    signal      cpt_15us        : NATURAL range 0 to cpt_15us_max;
    signal      cpt_500ms       : NATURAL range 0 to cpt_500ms_max;
    signal      cpt_read        : NATURAL range 0 to cpt_read_max;

    signal      flag_en         : STD_LOGIC;
    signal      sdata_en        : STD_LOGIC;
    signal      sdata_out       : STD_LOGIC_VECTOR (7 downto 0);
    signal      sread_idx       : UNSIGNED (3 downto 0);
    signal      sRES            : STD_LOGIC;  
    signal      sVCCEN          : STD_LOGIC;
    signal      sPMODEN         : STD_LOGIC;
    
    signal      current_state   : STD_LOGIC_VECTOR (3 downto 0);
    signal      next_state      : STD_LOGIC_VECTOR (3 downto 0);

begin
    
    current_state_generator : process(clk, reset)
        begin
            if reset = '1' then
                current_state <= std_logic_vector(to_unsigned(0, 4));
            else
                if rising_edge(clk) then
                    current_state <= next_state;
                end if;
            end if;
    end process;

    next_state_generator : process(current_state, cpt_150ms, cpt_15us, cpt_500ms, sread_idx, SPI_busy, cpt_read, sdata_en, flag_en)
        begin
            case current_state is
                when std_logic_vector(to_unsigned(0, 4)) =>
                    next_state <= std_logic_vector(to_unsigned(1, 4));
                when std_logic_vector(to_unsigned(1, 4)) =>
                    next_state <= std_logic_vector(to_unsigned(2, 4));
                when std_logic_vector(to_unsigned(2, 4)) =>
                    next_state <= std_logic_vector(to_unsigned(3, 4));
                when std_logic_vector(to_unsigned(3, 4)) =>
                    next_state <= std_logic_vector(to_unsigned(4, 4));
                when std_logic_vector(to_unsigned(4, 4)) =>
                    if cpt_150ms = (cpt_150ms_max-1) then
                        next_state <= std_logic_vector(to_unsigned(5, 4));
                    else
                        next_state <= std_logic_vector(to_unsigned(4, 4));
                    end if;
                when std_logic_vector(to_unsigned(5, 4)) =>
                    if cpt_15us = (cpt_15us_max-1) then
                        next_state <= std_logic_vector(to_unsigned(6, 4));
                    else
                        next_state <= std_logic_vector(to_unsigned(5, 4));
                    end if;
                when std_logic_vector(to_unsigned(6, 4)) =>
                    if cpt_15us = (cpt_15us_max-1) then
                        next_state <= std_logic_vector(to_unsigned(7, 4));--envoi des données d'init en SPI
                    else
                        next_state <= std_logic_vector(to_unsigned(6, 4));
                    end if;
                when std_logic_vector(to_unsigned(7, 4)) =>
                    if ( (SPI_busy = '0') AND (flag_en = '1') ) then
                        if sdata_en = '0' then
                            if cpt_read = cpt_read_max then
                                if sread_idx = read_idx_init then
                                    next_state <= std_logic_vector(to_unsigned(10, 4));
                                else
                                    if sread_idx = read_idx_rec then
                                        next_state <= std_logic_vector(to_unsigned(12, 4));
                                    else
                                        next_state <= std_logic_vector(to_unsigned(9, 4));
                                    end if;
                                end if;
                            else
                                next_state  <= std_logic_vector(to_unsigned(8, 4));
                            end if;
                        else
                            next_state <= std_logic_vector(to_unsigned(7, 4));
                        end if;
                    else
                        next_state <= std_logic_vector(to_unsigned(7, 4));
                    end if;
                when std_logic_vector(to_unsigned(8, 4)) =>
                    next_state <= std_logic_vector(to_unsigned(7, 4));
                when std_logic_vector(to_unsigned(9, 4)) =>
                    next_state <= std_logic_vector(to_unsigned(7, 4));
                when std_logic_vector(to_unsigned(10, 4)) =>
                    if cpt_150ms = (cpt_150ms_max-1) then
                        next_state <= std_logic_vector(to_unsigned(11, 4));--état final
                    else
                        next_state <= std_logic_vector(to_unsigned(10, 4));
                    end if;
                when std_logic_vector(to_unsigned(11, 4)) =>
                    if cpt_500ms = (cpt_500ms_max-1) then
                        next_state <= std_logic_vector(to_unsigned(12, 4));--état final
                    else
                        next_state <= std_logic_vector(to_unsigned(11, 4));
                    end if;
                when std_logic_vector(to_unsigned(12, 4)) =>
                    if sread_idx = read_idx_rec then
                        next_state <= std_logic_vector(to_unsigned(12, 4));
                    else
                        next_state <= std_logic_vector(to_unsigned(9, 4));
                    end if;
                when others =>
                    next_state <= std_logic_vector(to_unsigned(13, 4));--état d'erreur
                end case;
    end process;
    
    read_idx_incr : process(clk, reset)
        begin
            if reset = '1' then
                sread_idx <= to_unsigned(0, 4);
            else
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(9, 4)) then
                        sread_idx <= sread_idx + 1;
                    else
                        sread_idx <= sread_idx;
                    end if;
                end if;
            end if;
    end process;
    
    read_idx <= std_logic_vector(sread_idx);
    
    cpt_read_incr : process(clk, reset)
            begin
                if reset = '1' then
                    cpt_read <= 0;
                else
                    if rising_edge(clk) then
                        if current_state = std_logic_vector(to_unsigned(8, 4)) then
                            cpt_read <= cpt_read + 1;
                        else
                            if current_state = std_logic_vector(to_unsigned(9, 4)) then
                                cpt_read <= 0;
                            else
                                cpt_read <= cpt_read;
                            end if;
                        end if;
                    end if;
                end if;
        end process;
    
    cpt_150ms_en : process(clk, reset)
        begin
            if reset = '1' then
                cpt_150ms <= 0;
            else
                if rising_edge(clk) then
                    if ( (current_state = std_logic_vector(to_unsigned(4, 4))) OR (current_state = std_logic_vector(to_unsigned(10, 4))) ) then
                        if cpt_150ms = cpt_150ms_max-1 then
                            cpt_150ms <= 0;
                        else
                            cpt_150ms <= cpt_150ms + 1;
                        end if;
                    else 
                        cpt_150ms <= 0;
                    end if;
                end if;
            end if;
    end process;
    
    cpt_15us_en : process(clk, reset)
        begin
            if reset = '1' then
                cpt_15us <= 0;
            else
                if rising_edge(clk) then
                    if ( (current_state = std_logic_vector(to_unsigned(5, 4))) OR (current_state = std_logic_vector(to_unsigned(6, 4))) ) then
                        if cpt_15us = cpt_15us_max-1 then
                            cpt_15us <= 0;
                        else
                            cpt_15us <= cpt_15us + 1;
                        end if;
                    else 
                        cpt_15us <= 0;
                    end if;
                end if;
            end if;
    end process;
        
    cpt_500ms_en : process(clk, reset)
        begin
            if reset = '1' then
                cpt_500ms <= 0;
            else
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(11, 4)) then
                        if cpt_500ms = cpt_500ms_max-1 then
                            cpt_500ms <= 0;
                        else
                            cpt_500ms <= cpt_500ms + 1;
                        end if;
                    else 
                        cpt_500ms <= 0;
                    end if;
                end if;
            end if;
    end process;
    
--    outputs_generator : process(current_state)
--        begin
--            case current_state is
--                when std_logic_vector(to_unsigned(0, 4)) =>
--                    sRES        <= '0';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '0';
--                when std_logic_vector(to_unsigned(1, 4)) =>
--                    sRES        <= '0';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '0';
--                when std_logic_vector(to_unsigned(2, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '0';
--                when std_logic_vector(to_unsigned(3, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '0';
--                when std_logic_vector(to_unsigned(4, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '1';
--                when std_logic_vector(to_unsigned(5, 4)) =>
--                    sRES        <= '0';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '1'; 
--                when std_logic_vector(to_unsigned(6, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '1';                                             
--                when std_logic_vector(to_unsigned(7, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '1';
--                when std_logic_vector(to_unsigned(8, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '1';
--                when std_logic_vector(to_unsigned(9, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '0';
--                    sPMODEN     <= '1';
--                when std_logic_vector(to_unsigned(10, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '1';
--                    sPMODEN     <= '1';
--                when std_logic_vector(to_unsigned(11, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '1';
--                    sPMODEN     <= '1';
--                when std_logic_vector(to_unsigned(12, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '1';
--                    sPMODEN     <= '1';
--                when std_logic_vector(to_unsigned(13, 4)) =>
--                    sRES        <= '1';
--                    sVCCEN      <= '1';
--                    sPMODEN     <= '1';
--                when others =>
--                    sRES        <= '1';
--                    sVCCEN      <= '1';
--                    sPMODEN     <= '1';
--            end case;
--    end process;

    DC      <= '0';
    
    RES_generator : process(clk, reset)
        begin
            if reset = '1' then
                sRES <= '0';
            else
                if rising_edge(clk) then
                    if ( (current_state = std_logic_vector(to_unsigned(2, 4))) OR (current_state = std_logic_vector(to_unsigned(6, 4))) ) then
                        sRES <= '1';
                    else
                        if current_state = std_logic_vector(to_unsigned(5, 4)) then
                            sRES <= '0';
                        else
                            sRES <= sRES;
                        end if;
                    end if;
                end if;
            end if;
    end process;
       
    RES     <= sRES;
    
    VCCEN_generator : process(clk, reset)
        begin
            if reset = '1' then
                sVCCEN <= '0';
            else
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(10, 4)) then
                        sVCCEN <= '1';
                    else
                        if current_state = std_logic_vector(to_unsigned(3, 4)) then
                            sVCCEN <= '0';
                        else
                            sVCCEN <= sVCCEN;
                        end if;
                    end if;
                end if;
            end if;
    end process;
    
    VCCEN   <= sVCCEN;
    
    PMODEN_generator : process(clk, reset)
        begin
            if reset = '1' then
                sPMODEN <= '0';
            else 
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(4, 4)) then
                        sPMODEN <= '1';
                    else 
                        sPMODEN <= sPMODEN;
                    end if;
                end if;
            end if;
    end process;
    
    PMODEN  <= sPMODEN; 
    
    flag_en_generator : process(clk,reset)
        begin
            if reset = '1' then
                flag_en <= '0';
            else
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(7, 4)) then
                        if flag_en = '0' then
                            flag_en <= '1';     
                        else
                            if ( (SPI_busy = '0') AND (flag_en = '1') ) then
                                if sdata_en = '0' then
                                    flag_en <= '0';
                                else
                                    flag_en <= '1';
                                end if;
                            else
                                flag_en <= '1';
                            end if;
                        end if;
                    else
                        if current_state = std_logic_vector(to_unsigned(11,4)) then
                            flag_en <= '1';
                        else
                            flag_en <= '0';
                        end if;
                    end if;
                end if;
            end if;
    end process;
    
    data_en_generator : process(clk, reset)
        begin
            if reset = '1' then
                sdata_en <= '0';
            else
                if rising_edge(clk) then
                    if ( (current_state = std_logic_vector(to_unsigned(7, 4))) OR (current_state = std_logic_vector(to_unsigned(11, 4))) ) then
                        if flag_en = '0' then
                            sdata_en <= '1';
                        else
                            sdata_en <= '0';
                        end if;
                    else 
                        sdata_en <= '0';
                    end if;
                end if;
            end if;
    end process;
    
    data_en <= sdata_en;
    
    data_out_generator : process(current_state, cpt_read, data_in)
        begin
            if current_state = std_logic_vector(to_unsigned(11, 4)) then
                sdata_out <= X"AF";
            else
                case cpt_read is
                    when 0 =>
                        sdata_out <= data_in (31 downto 24);
                    when 1 =>
                        sdata_out <= data_in (23 downto 16);
                    when 2 =>
                        sdata_out <= data_in (15 downto 8);
                    when 3 =>
                        sdata_out <= data_in (7 downto 0);
                    when others =>
                        sdata_out <= std_logic_vector(to_unsigned(0, 8));
                end case;
            end if;
    end process;
    
    data_out <= sdata_out;
    
end Behavioral;
