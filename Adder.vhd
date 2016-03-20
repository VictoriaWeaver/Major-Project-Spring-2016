----------------------------------------------------------------------------------
-- File:			Adder.vhd
-- 
-- Entity:			Adder
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
-- 					32-bit adder.
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

entity Adder is
	Port ( Input1 : in  STD_LOGIC_VECTOR(31 downto 0);
			Input2 : in  STD_LOGIC_VECTOR(31 downto 0);
           	Output : out  STD_LOGIC_VECTOR(31 downto 0));
end Adder;


-- The adder takes 2 32-bit inputs and outputs the sum
architecture Dataflow of Adder is

begin

Output <= Input1 + Input2;

end Dataflow;

