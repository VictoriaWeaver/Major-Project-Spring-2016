-----------------------------------------------------------------
-- File:				Adder32.vhd
-- 
-- Entity:			Adder32
-- Architecture:	Structural
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		--
--					--
-- VHDL '93
-- Description:	The following is the entity and architectural 
--				description of a 32-bit adder.  Note that a
-- 				carry out bit is not used.
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

entity Adder32 is
    Port ( In1 : in  STD_LOGIC_VECTOR(32 downto 0);
           In2 : in  STD_LOGIC_VECTOR(32 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR(32 downto 0));
end Adder32;

architecture Structural of Adder32 is

-- Components

	-- 1-bit adder component
	component AdderBase
		port( A, B, Cin : in STD_LOGIC;
				Sum, Cout : out STD_LOGIC);
	end component;

-- Signals
-- Internal carry bit
signal Int_Carry : STD_LOGIC_VECTOR(16 downto 0);

begin
	-- Carry on the first adder is not internal
	Int_Carry(0) <= Cin;
	
	
	-- Generate 32 single bit adders to create a 32-bit 
	-- ripple adder
	-- Note that the last bit of the Int_Carry signal 
	-- will not be used.
	G1: for i in 0 to 31 generate
		Adders: AdderBase port map(In1(i), In2(i), Int_Carry(i), Sum(i), Int_Carry(i+1));
	end generate;
	
	
end Structural;


























