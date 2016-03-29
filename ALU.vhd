-----------------------------------------------------------------
-- File:				ALU.vhd
-- 
-- Entity:			ALU
-- Architecture:	Structural
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		
--					--
-- VHDL '93
-- Description:		The following is the entity and architectural 
--					description of a 32-bit ALU.
-- Control Logic:		Logical AND 	0000
--							Logical OR 		0001
--							Addition			0010
--							Logical NOT 	0111
--							Subtraction		0110
--							SLL				
--							SRL				
--							SRA				
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

entity ALU is
    Port ( In1 		: in  STD_LOGIC_VECTOR(31 downto 0);
           In2 		: in  STD_LOGIC_VECTOR(31 downto 0);
           Control 	: in  STD_LOGIC_VECTOR(3 downto 0);
           Output 	: out STD_LOGIC_VECTOR(31 downto 0);
           Zero 		: out STD_LOGIC);
end ALU;

architecture Structural of ALU is

--Components

--2X 32-bit 2:1 MUX
	component Mux32bit2_1 is
		Port ( 	Sel 	: in  STD_LOGIC;
           		In1 	: in  STD_LOGIC_VECTOR(31 downto 0);
					In2 	: in  STD_LOGIC_VECTOR(31 downto 0);
           		Output 	: out STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
--32-bit 32:1 MUX
	component Mux32s_1 is
    Port ( 	Sel : in  STD_LOGIC_VECTOR(4 downto 0);
			In0,In1,In2,In3,
			In4,In5,In6,In7,
			In8,In9,In10,In11,
			In12,In13,In14,In15,
			In16,In17,In18,In19,
			In20,In21,In22,In23,
			In24,In25,In26,In27,
			In28,In29,In30,In31 : in  STD_LOGIC_VECTOR(31 downto 0);
           	Output : out	STD_LOGIC_VECTOR(15 downto 0));
	end component;

--LU
	component LogicalUnit is
		Port ( 	In1 	: in  STD_LOGIC_VECTOR(31 downto 0);
           		In2 	: in  STD_LOGIC_VECTOR(31 downto 0);
           		Control : in  STD_LOGIC_VECTOR(3 downto 0);
			  	Output 	: out STD_LOGIC_VECTOR(31 downto 0));
	end component;

--ADDER 
	component Adder32 is
		Port (In1 : in  STD_LOGIC_VECTOR(31 downto 0);
				In2 : in  STD_LOGIC_VECTOR(31 downto 0);
				Cin : in  STD_LOGIC;
				Sum : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

--Shifter Unit
	component Shifter is
    	Port ( Input 	: in  STD_LOGIC_VECTOR(31 downto 0);
    	       Control 	: in  STD_LOGIC_VECTOR(1 downto 0);
    	       Shift 	: in  STD_LOGIC_VECTOR(4 downto 0);
    	       Output 	: out STD_LOGIC_VECTOR(31 downto 0));
	end component;

--Muxes
	component Mux2_1 is
		Port ( Sel : in  STD_LOGIC;
				In1 : in  STD_LOGIC_VECTOR(31 downto 0);
				In2 : in  STD_LOGIC_VECTOR(31 downto 0);
				Output : out	STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
	component Mux16_1 is
		Port ( Sel : in  STD_LOGIC_VECTOR(3 downto 0);
				In0,In1,In2,In3,In4,In5,In6,In7,In8,
				In9,In10,In11,In12,In13,In14,In15 : in  STD_LOGIC_VECTOR(31 downto 0);
				Output : out	STD_LOGIC_VECTOR(31 downto 0));
	end component;


--Signals
signal controlOutput: STD_LOGIC_VECTOR(31 downto 0);
signal AdderOut, ShiftOut, LUOut : STD_LOGIC_VECTOR(31 downto 0); 
signal subCarry: STD_LOGIC;

signal LUin1: STD_LOGIC_VECTOR(31 downto 0);
signal AdderIn2: STD_LOGIC_VECTOR(31 downto 0);
signal ground: STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";

signal buff: STD_LOGIC_VECTOR(31 downto 0);

begin
	
	--Logical Unit
	subCarry <= (not Control(3)) AND Control(2) AND Control(1) AND (not Control(0));
	
	LUMux: Mux2_1 port map(subCarry, In1, In2, LUin1);
	LU: LogicalUnit port map(LUin1, In2, Control, LUOut);

	
	--Adder Unit
	AdderMux: Mux2_1 port map(subCarry, In2, LUOut, AdderIn2);
	AdderUnit: Adder32 port map(In1, AdderIn2, subCarry, AdderOut);


	--Do NOT implement yet
	--Shifter Unit
	--ShiftUnit: Shifter port map(In1, Control(1 downto 0), In2(4 downto 0), ShiftOut);

	--Output MUX
	OutputMUX: Mux16_1 port map(Control, 
								LUOut, LUOut, AdderOut, ground,		
								ground, ground, AdderOut, LUOut,
								ground, ground, ground, ground,
								ground, ground, ground, ground,
								buff);

	-- Set the Zero Flag							
	Output <= buff;
	with buff select
		Zero <= '1' when "00000000000000000000000000000000",
				'0' when others;

end Structural;

