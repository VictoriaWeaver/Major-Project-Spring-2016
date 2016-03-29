-----------------------------------------------------------------
-- File:				ALUControl.vhd
-- 
-- Entity:			ALUControl
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		
--					
-- VHDL '93
-- Description:		The following is the entity and architectural 
--					description of the control logic for a 32-bit 
--					ALU.
-----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUControl is
	Port(	func 		: in STD_LOGIC_VECTOR(5 downto 0);
			ALUOp		: in STD_LOGIC_VECTOR(1 downto 0);
			Control	: out STD_LOGIC_VECTOR(3 downto 0));
end ALUControl;


architecture Dataflow of ALUControl is
begin
	Control(3) <= '0';

	Control(2) <= (ALUOp(1) AND func(1)) OR ALUOp(0);
	
	Control(1) <= (NOT ALUOp(1)) OR (NOT func(2));
	
	Control(0) <= (func(2) OR func(0)) AND ALUOp(1);
	
end Dataflow;