----------------------------------------------------------------------------------
-- File:				Decoder.vhd
-- 
-- Entity:			Decoder
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
-- 					5:32 decoder.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
    Port ( X : in  STD_LOGIC_VECTOR(4 downto 0);
           Z : out  STD_LOGIC_VECTOR(31 downto 0));
end Decoder;


-- 5:32 Decoder
-- The input designates which bit of the output is high.
-- If the input is n, the nth bit is one while the rest are 0.
architecture Dataflow of Decoder is

begin

	Z(0) <= 	not X(4) and not X(3) and not 	X(2) and not X(1) and not X(0);
	Z(1) <= 	not X(4) and not X(3) and not 	X(2) and not X(1) and 	  X(0);
	Z(2) <= 	not X(4) and not X(3) and not 	X(2) and 	 X(1) and not X(0);
	Z(3) <= 	not X(4) and not X(3) and not 	X(2) and	 X(1) and 	  X(0);
	Z(4) <= 	not X(4) and not X(3) and 		X(2) and not X(1) and not X(0);
	Z(5) <= 	not X(4) and not X(3) and		X(2) and not X(1) and 	  X(0);
	Z(6) <= 	not X(4) and not X(3) and		X(2) and 	 X(1) and not X(0);
	Z(7) <= 	not X(4) and not X(3) and		X(2) and 	 X(1) and 	  X(0);
	Z(8) <= 	not X(4) and 	 X(3) and not 	X(2) and not X(1) and not X(0);
	Z(9) <= 	not X(4) and 	 X(3) and not 	X(2) and not X(1) and 	  X(0);
	Z(10) <= 	not X(4) and 	 X(3) and not 	X(2) and 	 X(1) and not X(0);
	Z(11) <= 	not X(4) and 	 X(3) and not 	X(2) and	 X(1) and 	  X(0);
	Z(12) <= 	not X(4) and 	 X(3) and 		X(2) and not X(1) and not X(0);
	Z(13) <= 	not X(4) and 	 X(3) and		X(2) and not X(1) and 	  X(0);
	Z(14) <= 	not X(4) and 	 X(3) and		X(2) and 	 X(1) and not X(0);
	Z(15) <= 	not X(4) and 	 X(3) and		X(2) and 	 X(1) and 	  X(0);
	Z(16) <= 	 	X(4) and not X(3) and not 	X(2) and not X(1) and not X(0);
	Z(17) <= 	 	X(4) and not X(3) and not 	X(2) and not X(1) and 	  X(0);
	Z(18) <= 		X(4) and not X(3) and not 	X(2) and 	 X(1) and not X(0);
	Z(19) <=		X(4) and not X(3) and not 	X(2) and	 X(1) and 	  X(0);
	Z(20) <= 		X(4) and not X(3) and 		X(2) and not X(1) and not X(0);
	Z(21) <= 		X(4) and not X(3) and		X(2) and not X(1) and 	  X(0);
	Z(22) <= 		X(4) and not X(3) and		X(2) and 	 X(1) and not X(0);
	Z(23) <= 		X(4) and not X(3) and		X(2) and 	 X(1) and 	  X(0);
	Z(24) <= 	 	X(4) and 	 X(3) and not 	X(2) and not X(1) and not X(0);
	Z(25) <= 	 	X(4) and 	 X(3) and not 	X(2) and not X(1) and 	  X(0);
	Z(26) <= 		X(4) and 	 X(3) and not 	X(2) and 	 X(1) and not X(0);
	Z(27) <=		X(4) and 	 X(3) and not 	X(2) and	 X(1) and 	  X(0);
	Z(28) <= 		X(4) and 	 X(3) and 		X(2) and not X(1) and not X(0);
	Z(29) <= 		X(4) and 	 X(3) and		X(2) and not X(1) and 	  X(0);
	Z(30) <= 		X(4) and 	 X(3) and		X(2) and 	 X(1) and not X(0);
	Z(31) <= 		X(4) and 	 X(3) and		X(2) and 	 X(1) and 	  X(0);

end Dataflow;

