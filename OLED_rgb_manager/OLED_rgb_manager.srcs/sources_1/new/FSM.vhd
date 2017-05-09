----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2017 14:59:24
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
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
end FSM;

architecture Behavioral of FSM is

    constant    cpt_150ms_max   : NATURAL := 15000000;
    constant    cpt_15us_max    : NATURAL := 1500;
    constant    cpt_500ms_max   : NATURAL := 50000000;
    constant    read_idx_init   : NATURAL := 21;
    constant    read_idx_rec    : NATURAL := 29;
    constant    read_idx_bmp    : NATURAL := 6143;
    constant    cpt_read_max    : NATURAL := 1;
    
    signal      cpt_150ms       : NATURAL range 0 to cpt_150ms_max;
    signal      cpt_15us        : NATURAL range 0 to cpt_15us_max;
    signal      cpt_500ms       : NATURAL range 0 to cpt_500ms_max;
    signal      cpt_read        : NATURAL range 0 to cpt_read_max;

    signal      flag_en         : STD_LOGIC;
    signal      sdata_en        : STD_LOGIC;
    signal      sdata_out       : STD_LOGIC_VECTOR (7 downto 0);
    signal      sread_idx_mem   : UNSIGNED (4 downto 0);
    signal      sread_idx_ram   : UNSIGNED (12 downto 0);
    signal      sDC             : STD_LOGIC;
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

    --processus de détermination de l'état futur en fonction de l'état présent, des entrées et de différents signaux de contrôle
    next_state_generator : process(current_state, cpt_150ms, cpt_15us, cpt_500ms, sread_idx_mem, sread_idx_ram, SPI_busy, cpt_read, sdata_en, flag_en, sDC)
        begin
            case current_state is
                when std_logic_vector(to_unsigned(0, 4)) =>                     -- état d'initialisation
                    next_state <= std_logic_vector(to_unsigned(1, 4));
                when std_logic_vector(to_unsigned(1, 4)) =>                     -- mise à 0 de DC
                    next_state <= std_logic_vector(to_unsigned(2, 4));
                when std_logic_vector(to_unsigned(2, 4)) =>                     -- mise à 1 de RES  
                    next_state <= std_logic_vector(to_unsigned(3, 4));
                when std_logic_vector(to_unsigned(3, 4)) =>                     -- mise à 0 de VCCEN
                    next_state <= std_logic_vector(to_unsigned(4, 4));
                when std_logic_vector(to_unsigned(4, 4)) =>                     -- mise à 1 de PMODEN
                    if cpt_150ms = (cpt_150ms_max-1) then
                        next_state <= std_logic_vector(to_unsigned(5, 4));      -- temporisation de 150 ms
                    else
                        next_state <= std_logic_vector(to_unsigned(4, 4));
                    end if;
                when std_logic_vector(to_unsigned(5, 4)) =>                     -- mise à 0 de RES
                    if cpt_15us = (cpt_15us_max-1) then
                        next_state <= std_logic_vector(to_unsigned(6, 4));      -- temporisation de 15 us
                    else
                        next_state <= std_logic_vector(to_unsigned(5, 4));
                    end if;
                when std_logic_vector(to_unsigned(6, 4)) =>                     -- mise à 1 de RES
                    if cpt_15us = (cpt_15us_max-1) then
                        next_state <= std_logic_vector(to_unsigned(7, 4));      -- temporisation de 15 us
                    else
                        next_state <= std_logic_vector(to_unsigned(6, 4));
                    end if;
                when std_logic_vector(to_unsigned(7, 4)) =>                     -- envoi de données/commandes en SPI
                    if ( (SPI_busy = '0') AND (flag_en = '1') ) then
                        if sdata_en = '0' then                                  -- conditions satisfaites si envoi terminé
                            if cpt_read = cpt_read_max then
                                if sDC = '0' then
                                    if sread_idx_mem = read_idx_init then
                                        next_state <= std_logic_vector(to_unsigned(10, 4));
                                    else
                                        if sread_idx_mem = read_idx_rec then
                                            next_state <= std_logic_vector(to_unsigned(12, 4));
                                        else
                                            next_state <= std_logic_vector(to_unsigned(9, 4));
                                        end if;
                                    end if;
                                else
                                    if sread_idx_ram = read_idx_bmp then
                                        next_state <= std_logic_vector(to_unsigned(14, 4));
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
                when std_logic_vector(to_unsigned(8, 4)) =>                     -- incrémentation de cpt_read
                    next_state <= std_logic_vector(to_unsigned(7, 4));          
                when std_logic_vector(to_unsigned(9, 4)) =>                     -- incrémentation de l'indice de lecture courant
                    next_state <= std_logic_vector(to_unsigned(7, 4));
                when std_logic_vector(to_unsigned(10, 4)) =>                    -- mise à 1 de VCCEN
                    if cpt_150ms = (cpt_150ms_max-1) then
                        next_state <= std_logic_vector(to_unsigned(11, 4));     -- temporisation de 150 ms
                    else
                        next_state <= std_logic_vector(to_unsigned(10, 4));
                    end if;
                when std_logic_vector(to_unsigned(11, 4)) =>                    -- envoi de la commande d'allumage
                    if cpt_500ms = (cpt_500ms_max-1) then                       -- ici pas d'utilidation de l'état 7
                        next_state <= std_logic_vector(to_unsigned(12, 4));     -- on envoi directement la commande en sortie de la FSM
                    else
                        next_state <= std_logic_vector(to_unsigned(11, 4));     -- temporisation de 500 ms
                    end if;                                                     -- FIN DE L'INITIALISATION --
                when std_logic_vector(to_unsigned(12, 4)) =>
                    if sread_idx_mem = read_idx_rec then                        -- tracé du rectangle
                        next_state <= std_logic_vector(to_unsigned(13, 4));     -- dans le cas où le tracé a été fait, on passe à la suite
                    else
                        next_state <= std_logic_vector(to_unsigned(9, 4));
                    end if;
                when std_logic_vector(to_unsigned(13, 4)) =>                    -- mise à 1 de DC, passage en envoi donné
                    next_state <= std_logic_vector(to_unsigned(7, 4));          -- retour à l'état 7 afin d'envoyer l'image à l'écran
                when std_logic_vector(to_unsigned(14, 4)) =>                    -- mise à 0 de DC
                    next_state <= std_logic_vector(to_unsigned(13, 4));         -- retour vers l'état 13 --> rafraichissement continu de l'écran
                when others =>
                    next_state <= std_logic_vector(to_unsigned(15, 4));         -- état d'erreur
                end case;
    end process;
    
    read_idx_mem_incr : process(clk, reset)
        begin
            if reset = '1' then
                sread_idx_mem <= to_unsigned(0, 5);
            else
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(9, 4)) then
                        if sDC = '0' then
                            sread_idx_mem <= sread_idx_mem + 1;
                        else
                            sread_idx_mem <= sread_idx_mem;
                        end if;
                    else
                        sread_idx_mem <= sread_idx_mem;
                    end if;
                end if;
            end if;
    end process;
    
    read_idx_mem <= std_logic_vector(sread_idx_mem);
    
    read_idx_ram_incr : process(clk, reset)
        begin
            if reset = '1' then
                sread_idx_ram <= to_unsigned(0, 13);
            else
                if rising_edge(clk) then
                    if sDC = '1' then
                        if current_state = std_logic_vector(to_unsigned(9, 4)) then
                            sread_idx_ram <= sread_idx_ram + 1;
                        else
                            sread_idx_ram <= sread_idx_ram;
                        end if;
                    else
                        sread_idx_ram <= to_unsigned(0, 13);
                    end if;                   
                end if;
            end if;
    end process;
    
    read_idx_ram <= std_logic_vector(sread_idx_ram);
    
    cpt_read_incr : process(clk, reset)
            begin
                if reset = '1' then
                    cpt_read <= 0;
                else
                    if rising_edge(clk) then
                        if current_state = std_logic_vector(to_unsigned(8, 4)) then
                            cpt_read <= cpt_read + 1;
                        else
                            if ( (current_state = std_logic_vector(to_unsigned(9, 4))) OR (current_state = std_logic_vector(to_unsigned(13, 4))) ) then
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

    DC_generator : process(clk, reset)
        begin
            if reset = '1' then
                sDC <= '0';
            else
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(13, 4)) then
                        sDC <= '1';
                    else
                        if ( (current_state = std_logic_vector(to_unsigned(1, 4))) OR (current_state = std_logic_vector(to_unsigned(14, 4))) ) then
                            sDC <= '0';
                        else
                            sDC <= sDC;
                        end if;
                    end if;
                end if;
            end if;
    end process;
    
    DC      <= sDC;
    
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
      
    data_out_generator : process(current_state, cpt_read, data_in_mem, data_in_ram, sDC)
        begin
            if current_state = std_logic_vector(to_unsigned(11, 4)) then
                sdata_out <= X"AF";
            else
                if sDC = '0' then
                    case cpt_read is
                        when 0 =>
                            sdata_out <= data_in_mem (15 downto 8);
                        when 1 =>
                            sdata_out <= data_in_mem (7 downto 0);
                        when others =>
                            sdata_out <= std_logic_vector(to_unsigned(0, 8));
                    end case;
                else
                    case cpt_read is
                        when 0 =>
                            sdata_out <= data_in_ram (15 downto 8);
                        when 1 =>
                            sdata_out <= data_in_ram (7 downto 0);
                        when others =>
                            sdata_out <= std_logic_vector(to_unsigned(0, 8));
                    end case;
                end if;
            end if;
    end process;
    
    data_out <= sdata_out;
    
end Behavioral;
