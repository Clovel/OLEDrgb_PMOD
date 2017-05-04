-- MARINO Xavier & DURAND Clovis
-- ENSEIRB-Matmeca, E2
-- 2017 - PR214
-- OLEDrgb PMOD

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FSM_OLEDrgb is
	port (	clk 	: in std_logic;
			reset 	: in std_logic;
			E_init	: out std_logic;
			E_truc	: out std_logic
		 );
end entity FSM_OLEDrgb;

architecture FSM of FSM_OLEDrgb is

-- Signaux nessesaires

	-- Signaux d'etat
	signal current_state : std_logic_vector;
	signal next_state    : std_logic_vector;

begin

-- Process changement d'etat
change_state: process (clk, reset)
begin

	if RAZ = '1' then
		current_state 	<= (others => '0');
	elsif rising_edge(clk) then
		current_state <= next_state;
	end if;

end process; 

-- Process qui affecte les sorties en fonction de l'etat courant. 
do_state: process -- inputs in sensibility list
begin



end process;

end FSM;