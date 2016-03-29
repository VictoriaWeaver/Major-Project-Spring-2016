-----------------------------------------------------------------
-- File:				Mux.vhd
-- 
-- Entity:			Mux
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:
--
-- VHDL '93
-- Description:	The following is the entity and architectural 
--						description of a 32:1 MUX.
-----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux32_1 is
    Port ( 	Sel : in  STD_LOGIC_VECTOR(4 downto 0);
			In0,In1,In2,In3,
			In4,In5,In6,In7,
			In8,In9,In10,In11,
			In12,In13,In14,In15,
			In16,In17,In18,In19,
			In20,In21,In22,In23,
			In24,In25,In26,In27,
			In28,In29,In30,In31 : in  STD_LOGIC_VECTOR(32 downto 0);
           	Output : out	STD_LOGIC_VECTOR(15 downto 0));
end Mux32_1;

architecture Dataflow of Mux32_1 is

begin
	Output <= 	In0 when (Sel = "00000") else
				In1 when (Sel = "00001") else
				In2 when (Sel = "00010") else
				In3 when (Sel = "00011") else
				In4 when (Sel = "00100") else
				In5 when (Sel = "00101") else
				In6 when (Sel = "00110") else
				In7 when (Sel = "00111") else
				In8 when (Sel = "01000") else
				In9 when (Sel = "01001") else
				In10 when (Sel = "01010") else
				In11 when (Sel = "01011") else
				In12 when (Sel = "01100") else
				In13 when (Sel = "01101") else
				In14 when (Sel = "01110") else
				In15 when (Sel = "01111") else
				In16 when (Sel = "10000") else
				In17 when (Sel = "10001") else
				In18 when (Sel = "10010") else
				In19 when (Sel = "10011") else
				In20 when (Sel = "10100") else
				In21 when (Sel = "10101") else
				In22 when (Sel = "10110") else
				In23 when (Sel = "10111") else
				In24 when (Sel = "11000") else
				In25 when (Sel = "11001") else
				In26 when (Sel = "11010") else
				In27 when (Sel = "11011") else
				In28 when (Sel = "11100") else
				In29 when (Sel = "11101") else
				In30 when (Sel = "11110") else
				In31;

end Dataflow;

