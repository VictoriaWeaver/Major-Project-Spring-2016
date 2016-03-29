-----------------------------------------------------------------
-- File:			AdderBase.vhd
-- 
-- Entity:			AdderBase
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		--
--					--
-- VHDL '93
-- Description:	The following is the entity and architectural 
--						description of a 1-bit adder.
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

entity AdderBase is
    Port ( A 	: in  STD_LOGIC;
           B 	: in  STD_LOGIC;
           Cin 	: in  STD_LOGIC;
           Sum 	: out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end AdderBase;

architecture Dataflow of AdderBase is

begin
	-- Simple 1-bit adder with carry
	Sum <= A XOR B XOR Cin;
	Cout <= (A AND B) OR ((A XOR B) AND Cin);
	
end Dataflow;

