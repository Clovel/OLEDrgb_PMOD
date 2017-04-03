-- MARINO Xavier & DURAND Clovis
-- ENSEIRB-Matmeca, E2
-- 2017 - PR214
-- OLEDrgb PMOD

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity G_Horloge is
    Port ( H : in STD_LOGIC;
           RAZ : in STD_LOGIC;
           CEA : out STD_LOGIC;
           CED : out STD_LOGIC;
           CEC : out STD_LOGIC);
end G_Horloge;

architecture Behavioral of G_Horloge is

signal NA : integer range 0 to 10000; -- compteurs respectifs de CEA,CED,CEC.
signal ND : integer range 0 to 200000000;
signal NC : integer range 0 to 100000000;

begin

CE_10kHz : process(H,RAZ) -- Compteur CEA

begin

	if (RAZ = '1') then
		NA <= 0;
		CEA <= '0';

	elsif (rising_edge(H)) then
		if (NA = 9999) then
			NA <= 0;
			CEA <= '1';
		else
			NA <= NA + 1;
			CEA <= '0';
		end if;
	end if;

end process;             

CE_0_5Hz : process(H,RAZ) -- Compteur CED

begin

	if ( RAZ = '1' ) then
		ND <= 0;
		CED <= '0';
	elsif ( rising_edge(H)) then
		if ( ND = 199999999 ) then -- en vrai 99999999 mais 1s reelle = 100s en projet pr sim
			ND <= 0;
			CED <= '1';
		else
			ND <= ND + 1;
			CED <= '0';
		end if;
	end if;

end process;             

CE_1Hz : process(H,RAZ) -- Compteur CEC

begin

	if ( RAZ = '1' ) then
		NC <= 0;
		CEC <= '0';

	elsif ( rising_edge(H)) then
		if ( NC = 99999999 ) then -- en vrai 99999999 mais 1s reelle = 100s en projet pr sim
			NC <= 0;
			CEC <= '1';
		else
			NC <= NC + 1;
			CEC <= '0';
		end if;
	end if;

end process;             
            


end Behavioral;
