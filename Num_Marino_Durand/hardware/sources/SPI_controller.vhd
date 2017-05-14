----------------------------------------------------------------------------------
-- Xavier Marino & Clovis Durand
-- 
-- Create Date: 03.04.2017 10:36:36
-- Module Name: SPI_controller - Behavioral
-- Project Name: Pmod OLEDrgb Manager
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SPI_controller is
    Port 
    (
        clk         : in  STD_LOGIC;                                    -- horloge de fonctionnement
        reset       : in  STD_LOGIC;                                    -- RAZ
        data_en     : in  STD_LOGIC;                                    -- signal d'enable contrôlant l'envoi d'un octet, provient de la FSM
        data_in     : in  STD_LOGIC_VECTOR (7 downto 0);                -- octet à transmettre, provient de la FSM
        sclk        : out STD_LOGIC;                                    -- entrée sclk du Pmod
        cs          : out STD_LOGIC;                                    -- entrée CS du Pmod
        MOSI        : out STD_LOGIC;                                    -- entrée MOSI du Pmod
        SPI_busy    : out STD_LOGIC;                                    -- signal d'occupation, envoyé vers la FSM
        MISO        : in  STD_LOGIC                                     -- sortie MISO du Pmod
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
    
    -- génération de l'horloge de fonctionnement du SPI
    sclk_generator : process (clk, reset)
        begin
            if reset = '1' then
                ssclk       <= '0';
                cpt_sclk    <= 0;
                cpt_octet   <= 7;
            else
                if rising_edge(clk) then    
                    if cpt_sclk = 0 then                            -- début d'une période                   
                        if data_en = '1' then                           -- déclenchement lorsque data_en est à 1, première période
                            ssclk       <= '1';
                            cpt_sclk    <= cpt_sclk + 1;
                            cpt_octet   <= 0;
                        elsif cpt_octet /= 7 then                       -- on compte le nombre de période, période deux à huit
                            ssclk       <= '1';
                            cpt_sclk    <= cpt_sclk + 1;
                            cpt_octet   <= cpt_octet +1;
                        else                                            -- les huits périodes sont passées, on abaisse sclk et on ne remet 
                            ssclk <= '0';                               -- pas à 0 le compteur relatif à la fréquence de sclk
                            cpt_sclk     <= cpt_sclk;
                        end if;   
                    else                                            -- en cours de période, on test le compteur relatif à la fréquence de sclk
                        if cpt_sclk < 9 then                            
                            ssclk       <= '1';
                            cpt_sclk    <= cpt_sclk + 1;
                        elsif cpt_sclk = (cpt_sclk_max - 1) then        -- fin d'une période, on retourne dans la boucle du dessus
                            ssclk       <= '0';
                            cpt_sclk    <= 0;
                        else                                            -- valeur médiane, on abaisse sclk
                            ssclk <= '0';
                            cpt_sclk    <= cpt_sclk + 1;
                        end if;                        
                    end if;                   
                end if;
            end if;
    end process;
    
    sclk <= NOT(ssclk);
    
    -- génération du signal d'occupation
    SPI_busy_generator : process(clk, reset)
        begin
            if reset = '1' then
                sSPI_busy <= '0';
            else
                if rising_edge(clk) then
                    if data_en = '1' then                           -- lorsque data_en passe à 1 on vient activer SPI_busy
                        sSPI_busy <= '1';
                    else
                        if cpt_octet = 7 then
                            if cpt_sclk = 17 then                   -- on passe SPI_busy à 0 lorsque la dernière période de l'envoi est terminée
                                sSPI_busy <= '0';
                            end if;
                        end if;
                    end if;
                end if;
            end if;
    end process;
                        
    SPI_busy <= sSPI_busy;
    
    -- processus de sauvegarde de l'entrée et de décalage des bits de l'octet à envoyer                
    data_in_save : process(clk, reset)
        begin
            if reset = '1' then
                sdata_in <= "00000000";
            else
                if rising_edge(clk) then
                    if data_en = '1' then                           -- lorsque data_en passe à 1 on vient récupérer la valeur de data_in
                        sdata_in <= data_in;
                    else
                        if ssclk = '1' then
                            if cpt_sclk = 1 then                    -- à chaque période de sclk on vient décaler les bits de sdata_in afin de lire l'octet en entier
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
    
    -- processus de mise à jour de la sortie (aurait pu être une simple recopie de sdata_in)
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
