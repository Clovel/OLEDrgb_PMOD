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
        clk             : in  STD_LOGIC;                                        -- horloge du FPGA
        reset           : in  STD_LOGIC;                                        -- RAZ
        SPI_busy        : in  STD_LOGIC;                                        -- signal d'occupation provenant du podule SPI
        data_in_mem     : in  STD_LOGIC_VECTOR (15 downto 0);                   -- donn�e provenant de MEM_init
        data_in_ram     : in  STD_LOGIC_VECTOR (15 downto 0);                   -- donn�e provenant de RAM
        data_en         : out STD_LOGIC;                                        -- signal d'enable contr�lant l'envoi d'un octet via le protocole SPI
        data_out        : out STD_LOGIC_VECTOR (7 downto 0);                    -- sortie de la FSM reli�e � l'entr�e du module SPI
        read_idx_mem    : out STD_LOGIC_VECTOR (4 downto 0);                    -- indice de lecture de MEM_init 
        read_idx_ram    : out STD_LOGIC_VECTOR (12 downto 0);                   -- indice de lecture de RAM
        DC              : out STD_LOGIC;                                        -- entr�e DC du Pmod
        RES             : out STD_LOGIC;                                        -- entr�e RES du Pmod
        VCCEN           : out STD_LOGIC;                                        -- entr�e VCCEN du Pmod
        PMODEN          : out STD_LOGIC                                         -- entr�e PMODEN du Pmod
    );
end FSM;

architecture Behavioral of FSM is

    constant    cpt_150ms_max   : NATURAL := 15000000;                          -- valeur maximale du compteur g�n�rant une temporisation de 150 ms
    constant    cpt_15us_max    : NATURAL := 1500;                              -- valeur maximale du compteur g�n�rant une temporisation de 15 us
    constant    cpt_500ms_max   : NATURAL := 50000000;                          -- valeur maximale du compteur g�n�rant une temporisation de 500 ms
    constant    read_idx_init   : NATURAL := 21;                                -- derni�re ligne de MEM_init contenant les commandes d'initialisation
    constant    read_idx_rec    : NATURAL := 29;                                -- derni�re ligne de MEM_init contenant les commandes de trac� de rectangle
    constant    read_idx_bmp    : NATURAL := 6143;                              -- derni�re ligne de la RAM
    constant    cpt_read_max    : NATURAL := 1;                                 -- valeur maximale du compteur qui parcours les octets d'une case m�moire (initialement � 3 car donn�es sur 32 bits)
    
    signal      cpt_150ms       : NATURAL range 0 to cpt_150ms_max;             -- compteur g�n�rant une temporisation de 150 ms
    signal      cpt_15us        : NATURAL range 0 to cpt_15us_max;              -- compteur g�n�rant une temporisation de 15 us
    signal      cpt_500ms       : NATURAL range 0 to cpt_500ms_max;             -- compteur g�n�rant une temporisation de 500 ms
    signal      cpt_read        : NATURAL range 0 to cpt_read_max;              -- compteur qui parcours les octets d'une case m�moire (initialement d�finie judsqu'� 3 d'o� la non utilisation d'un signal logique)
    signal      flag_en         : STD_LOGIC;                                    -- signal logique n�cessaire � la d�termination de data_en
    signal      sdata_en        : STD_LOGIC;                                    -- signal interm�diaire � la d�termination de data_en 
    signal      sdata_out       : STD_LOGIC_VECTOR (7 downto 0);                -- signal interm�diaire � la d�termination de data_out 
    signal      sread_idx_mem   : UNSIGNED (4 downto 0);                        -- signal interm�diaire � la d�termination de read_idx_mem
    signal      sread_idx_ram   : UNSIGNED (12 downto 0);                       -- signal interm�diaire � la d�termination de read_idx_ram 
    signal      sDC             : STD_LOGIC;                                    -- signal interm�diaire � la d�termination de DC
    signal      sRES            : STD_LOGIC;                                    -- signal interm�diaire � la d�termination de RES
    signal      sVCCEN          : STD_LOGIC;                                    -- signal interm�diaire � la d�termination de VCCEN
    signal      sPMODEN         : STD_LOGIC;                                    -- signal interm�diaire � la d�termination de PMODEN
    
    signal      current_state   : STD_LOGIC_VECTOR (3 downto 0);                -- �tat pr�sent de la machine d'�tat
    signal      next_state      : STD_LOGIC_VECTOR (3 downto 0);                -- �tat futur de la machine d'�tat

begin
    
    -- processus de mise � jour de l'�tat pr�sent
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

    -- processus de d�termination de l'�tat futur en fonction de l'�tat pr�sent, des entr�es et de diff�rents signaux de contr�le
    next_state_generator : process(current_state, cpt_150ms, cpt_15us, cpt_500ms, sread_idx_mem, sread_idx_ram, SPI_busy, cpt_read, sdata_en, flag_en, sDC)
        begin
            case current_state is
                when std_logic_vector(to_unsigned(0, 4)) =>                     -- �tat d'initialisation
                    next_state <= std_logic_vector(to_unsigned(1, 4));
                when std_logic_vector(to_unsigned(1, 4)) =>                     -- mise � 0 de DC
                    next_state <= std_logic_vector(to_unsigned(2, 4));
                when std_logic_vector(to_unsigned(2, 4)) =>                     -- mise � 1 de RES  
                    next_state <= std_logic_vector(to_unsigned(3, 4));
                when std_logic_vector(to_unsigned(3, 4)) =>                     -- mise � 0 de VCCEN
                    next_state <= std_logic_vector(to_unsigned(4, 4));
                when std_logic_vector(to_unsigned(4, 4)) =>                     -- mise � 1 de PMODEN
                    if cpt_150ms = (cpt_150ms_max-1) then
                        next_state <= std_logic_vector(to_unsigned(5, 4));      -- temporisation de 150 ms
                    else
                        next_state <= std_logic_vector(to_unsigned(4, 4));
                    end if;
                when std_logic_vector(to_unsigned(5, 4)) =>                     -- mise � 0 de RES
                    if cpt_15us = (cpt_15us_max-1) then
                        next_state <= std_logic_vector(to_unsigned(6, 4));      -- temporisation de 15 us
                    else
                        next_state <= std_logic_vector(to_unsigned(5, 4));
                    end if;
                when std_logic_vector(to_unsigned(6, 4)) =>                     -- mise � 1 de RES
                    if cpt_15us = (cpt_15us_max-1) then
                        next_state <= std_logic_vector(to_unsigned(7, 4));      -- temporisation de 15 us
                    else
                        next_state <= std_logic_vector(to_unsigned(6, 4));
                    end if;
                when std_logic_vector(to_unsigned(7, 4)) =>                     -- envoi de donn�es/commandes en SPI
                    if ( (SPI_busy = '0') AND (flag_en = '1') ) then
                        if sdata_en = '0' then                                  -- conditions satisfaites si envoi termin�
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
                when std_logic_vector(to_unsigned(8, 4)) =>                     -- incr�mentation de cpt_read
                    next_state <= std_logic_vector(to_unsigned(7, 4));          
                when std_logic_vector(to_unsigned(9, 4)) =>                     -- incr�mentation de l'indice de lecture courant
                    next_state <= std_logic_vector(to_unsigned(7, 4));
                when std_logic_vector(to_unsigned(10, 4)) =>                    -- mise � 1 de VCCEN
                    if cpt_150ms = (cpt_150ms_max-1) then
                        next_state <= std_logic_vector(to_unsigned(11, 4));     -- temporisation de 150 ms
                    else
                        next_state <= std_logic_vector(to_unsigned(10, 4));
                    end if;
                when std_logic_vector(to_unsigned(11, 4)) =>                    -- envoi de la commande d'allumage
                    if cpt_500ms = (cpt_500ms_max-1) then                       -- ici pas d'utilidation de l'�tat 7
                        next_state <= std_logic_vector(to_unsigned(12, 4));     -- on envoi directement la commande en sortie de la FSM
                    else
                        next_state <= std_logic_vector(to_unsigned(11, 4));     -- temporisation de 500 ms
                    end if;                                                     -- FIN DE L'INITIALISATION --
                when std_logic_vector(to_unsigned(12, 4)) =>
                    if sread_idx_mem = read_idx_rec then                        -- trac� du rectangle
                        next_state <= std_logic_vector(to_unsigned(13, 4));     -- dans le cas o� le trac� a �t� fait, on passe � la suite
                    else
                        next_state <= std_logic_vector(to_unsigned(9, 4));
                    end if;
                when std_logic_vector(to_unsigned(13, 4)) =>                    -- mise � 1 de DC, passage en envoi donn�
                    next_state <= std_logic_vector(to_unsigned(7, 4));          -- retour � l'�tat 7 afin d'envoyer l'image � l'�cran
                when std_logic_vector(to_unsigned(14, 4)) =>                    -- mise � 0 de DC
                    next_state <= std_logic_vector(to_unsigned(13, 4));         -- retour vers l'�tat 13 --> rafraichissement continu de l'�cran
                when others =>
                    next_state <= std_logic_vector(to_unsigned(15, 4));         -- �tat d'erreur
                end case;
    end process;
    
    -- incr�mentation de l'indice de lecture de MEM_init
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
    
    -- incr�mentation de l'indice de lecture de RAM
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
    
    -- incr�mentation du compteur d'octets
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
    
    -- incr�mentation du compteur 150 ms
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
    
    -- incr�mentation du compteur 15 us
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
        
    -- incr�mentation du compteur 500 ms
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

    -- processus de set et reset de l'entr�e DC du Pmod
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
    
    -- processus de set et reset de l'entr�e RES du Pmod
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
    
    -- processus de set et reset de l'entr�e VCCEN du Pmod
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
    
    -- processus de set et reset de l'entr�e PMODEN du Pmod
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
    
    -- g�n�ration du flag de contr�le de data_en
    flag_en_generator : process(clk,reset)
        begin
            if reset = '1' then
                flag_en <= '0';
            else
                if rising_edge(clk) then
                    if current_state = std_logic_vector(to_unsigned(7, 4)) then     
                        if flag_en = '0' then
                            flag_en <= '1';                                      -- flag_en passe � 1 d�s le d�but l'envoi d'un octet en SPI, une p�riode d'horloge plus t�t que SPI_busy
                        else
                            if ( (SPI_busy = '0') AND (flag_en = '1') ) then
                                if sdata_en = '0' then
                                    flag_en <= '0';                              -- flag_en passe � 0 seulement lorsque l'envoi d'un octet est termin�
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
    
    -- g�n�ration du flag data_en
    data_en_generator : process(clk, reset)
        begin
            if reset = '1' then
                sdata_en <= '0';
            else
                if rising_edge(clk) then
                    if ( (current_state = std_logic_vector(to_unsigned(7, 4))) OR (current_state = std_logic_vector(to_unsigned(11, 4))) ) then
                        if flag_en = '0' then
                            sdata_en <= '1';                                    -- data_en passe � 1
                        else
                            sdata_en <= '0';                                    -- il y reste pendant une p�riode d'horloge, puis il passe niveau bas pendant le reste de l'envoi
                        end if;
                    else 
                        sdata_en <= '0';
                    end if;
                end if;
            end if;
    end process;
    
    data_en <= sdata_en;
    

    -- processus de gestion du signal � envoyer en entr�e du modue SPI  
    data_out_generator : process(current_state, cpt_read, data_in_mem, data_in_ram, sDC)
        begin
            if current_state = std_logic_vector(to_unsigned(11, 4)) then
                sdata_out <= X"AF";                                             -- commande d'allumage de l'�cran 
            else
                if sDC = '0' then                                               -- envoi des commandes d'initialisation
                    case cpt_read is
                        when 0 =>
                            sdata_out <= data_in_mem (15 downto 8);             -- envoi de l'octet de poids fort
                        when 1 =>
                            sdata_out <= data_in_mem (7 downto 0);              -- puis de l'octet de poids faible
                        when others =>
                            sdata_out <= std_logic_vector(to_unsigned(0, 8));
                    end case;
                else                                                            -- envoi des donn�es de l'image
                    case cpt_read is
                        when 0 =>
                            sdata_out <= data_in_ram (15 downto 8);             -- envoi de l'octet de poids fort
                        when 1 =>
                            sdata_out <= data_in_ram (7 downto 0);              -- puis de l'octet de poids faible
                        when others =>
                            sdata_out <= std_logic_vector(to_unsigned(0, 8));
                    end case;
                end if;
            end if;
    end process;
    
    data_out <= sdata_out;
    
end Behavioral;
