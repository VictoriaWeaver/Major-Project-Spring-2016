-----------------------------------------------------------------
-- File:			Shifter.vhd
-- 
-- Entity:			Shifter
-- Architecture:	Behavioral
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		--
--
-- VHDL '93
-- Description:	The following is the entity and architectural 
--						description of a 32-bit logical unit.
-----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shifter is
    Port ( Input : in  STD_LOGIC_VECTOR(31 downto 0);
           Control : in  STD_LOGIC_VECTOR(1 downto 0);
           Shift : in  STD_LOGIC_VECTOR(4 downto 0);
           Output : out  STD_LOGIC_VECTOR(31 downto 0));
end Shifter;

architecture Behavioral of Shifter is

-- 32-bit 2:1 MUX
component Mux2_1 is
	Generic( n : integer := 32 );
    Port (	S 		: in  STD_LOGIC;
           	W0,W1 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           	Z 		: out STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- Signals
signal sll1, sll2, sll3, sll4, sll5: STD_LOGIC_VECTOR(31 downto 0);
signal srl1, srl2, srl3, srl4, srl5: STD_LOGIC_VECTOR(31 downto 0);
signal sra1, sra2, sra3, sra4, sra5: STD_LOGIC_VECTOR(31 downto 0);

signal sllo1, sllo2, sllo3, sllo4: STD_LOGIC_VECTOR(31 downto 0);
signal srlo1, srlo2, srlo3, srlo4: STD_LOGIC_VECTOR(31 downto 0);
signal srao1, srao2, srao3, srao4: STD_LOGIC_VECTOR(31 downto 0);

signal Output1, Output2, Output3, Output4: STD_LOGIC_VECTOR(31 downto 0);

signal ground1: STD_LOGIC_VECTOR(15 downto 0);
signal ground2: STD_LOGIC_VECTOR(7 downto 0);
signal ground3: STD_LOGIC_VECTOR(3 downto 0);
signal ground4: STD_LOGIC_VECTOR(1 downto 0);
signal ground5: STD_LOGIC;

signal logical1: STD_LOGIC_VECTOR(15 downto 0);
signal logical2: STD_LOGIC_VECTOR(7 downto 0);
signal logical3: STD_LOGIC_VECTOR(3 downto 0);
signal logical4: STD_LOGIC_VECTOR(1 downto 0);
signal logical5: STD_LOGIC;

begin
		ground1 <= (others => '0');
		ground2 <= (others => '0');
		ground3 <= (others => '0');
		ground4 <= (others => '0');
		ground5 <= '0';
		
		logical1 <= (others => Input(31));
		logical2 <= (others => Input(31));
		logical3 <= (others => Input(31));
		logical4 <= (others => Input(31));
		logical5 <= Input(31);

	-- SLL								
		sll1 <= Input(15 downto 0) & ground1;
		sll2 <= sllo1(23 downto 0) & ground2;
		sll3 <= sllo2(27 downto 0) & ground3;
		sll4 <= sllo3(29 downto 0) & ground4;
		sll5 <= sllo3(30 downto 0) & ground4;
		
		Stage1SLL: Mux2_1 port map(Shift(4), Input(31 downto 0), sll1, sllo1);
		Stage2SLL: Mux2_1 port map(Shift(3), sllo1(31 downto 0), sll2, sllo2);
		Stage3SLL: Mux2_1 port map(Shift(2), sllo2(31 downto 0), sll3, sllo3);
		Stage4SLL: Mux2_1 port map(Shift(1), sllo3(31 downto 0), sll4, sllo4);
		Stage4SLL: Mux2_1 port map(Shift(0), sllo4(31 downto 0), sll5, Output1);
		
	-- SRL
	
		srl1 <= ground1 & Input(31 downto 16);
		srl2 <= ground2 & srlo1(31 downto 8);
		srl3 <= ground3 & srlo2(31 downto 4);
		srl4 <= ground4 & srlo3(31 downto 2);
		srl5 <= ground4 & srlo3(31 downto 1);

		Stage1SRL: Mux2_1 port map(Shift(4), Input(31 downto 0), srl1, srlo1);
		Stage2SRL: Mux2_1 port map(Shift(3), srlo1(31 downto 0), srl2, srlo2);
		Stage3SRL: Mux2_1 port map(Shift(2), srlo2(31 downto 0), srl3, srlo3);
		Stage4SRL: Mux2_1 port map(Shift(1), srlo3(31 downto 0), srl4, srlo4);
		Stage5SRL: Mux2_1 port map(Shift(0), srlo4(31 downto 0), srl5, Output2);
		
	-- SRA
		
		sra1 <= logical1 & Input(31 downto 16);
		sra2 <= logical2 & srao1(31 downto 8);
		sra3 <= logical3 & srao2(31 downto 4);
		sra4 <= logical4 & srao3(31 downto 2);
		sra5 <= logical5 & srao4(31 downto 1);
		
		Stage1SRA: Mux2_1 port map(Shift(4), Input(31 downto 0), sra1, srao1);
		Stage2SRA: Mux2_1 port map(Shift(3), srao1(31 downto 0), sra2, srao2);
		Stage3SRA: Mux2_1 port map(Shift(2), srao2(31 downto 0), sra3, srao3);
		Stage4SRA: Mux2_1 port map(Shift(1), srao3(31 downto 0), sra4, srao4);
		Stage4SRA: Mux2_1 port map(Shift(0), srao4(31 downto 0), sra5, Output3);
		
	
		Output <= 	Output1 when Control = "00" else
					Output2 when Control = "01" else
					Output3 when Control = "10" else
					Input;
		

end Behavioral;

