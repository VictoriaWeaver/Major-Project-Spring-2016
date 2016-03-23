-----------------------------------------------------------------
-- File:				LogicalUnit.vhd
-- 
-- Entity:			LogicalUnit
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		--
--					--
-- VHDL '93
-- Description:	The following is the entity and architectural 
--						description of a 32-bit logical unit.
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

entity LogicalUnit is
    Port ( 	In1 	: in  STD_LOGIC_VECTOR(31 downto 0);
           	In2 	: in  STD_LOGIC_VECTOR(31 downto 0);
           	Control : in  STD_LOGIC_VECTOR(3 downto 0);
			Output 	: out STD_LOGIC_VECTOR(31 downto 0));
end LogicalUnit;

architecture Dataflow of LogicalUnit is

begin
			with Control select
			Output <= (In1 AND In2) when "0000",
						(NOT In1) when "0111",
						(In1 OR In2) when "0001",
						"00000000000000000000000000000000" when others;
		
end Dataflow;

