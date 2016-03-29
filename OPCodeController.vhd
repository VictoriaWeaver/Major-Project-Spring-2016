-----------------------------------------------------------------
-- File:				ALUControl.vhd
-- 
-- Entity:			OPCodeController
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/28/16
-- Modified:		
--					
-- VHDL '93
-- Description:	The following is the entity and architectural 
--						description of the control logic for the ISA
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

entity OPCodeController is
	Port(	func 		: in STD_LOGIC_VECTOR(5 downto 0);		
			Control	: out STD_LOGIC_VECTOR(7 downto 0));
end OPCodeController;


architecture Dataflow of OPCodeController is

signal RFormat : STD_LOGIC;
signal lw : STD_LOGIC;
signal sw : STD_LOGIC;
signal beq : STD_LOGIC;


begin
	RFormat <= (not func(0)) and (not func(1)) and (not func(2)) and (not func(3)) and (not func(4)) and (not func(5)); 
	lw <= func(0) and (not func(1)) and (not func(2)) and (not func(3)) and func(4) and func(5);
	sw <= func(0) and (not func(1)) and func(2) and (not func(3)) and func(4) and func(5); 
	beq <= (not func(0)) and (not func(1)) and (not func(2)) and func(3) and (not func(4)) and (not func(5));



	Control(0) <= RFormat;
	Control(1) <= lw OR sw;
	Control(2) <= lw;
	Control(3) <= RFormat OR lw;
	Control(4) <= lw;
	Control(5) <= sw;
	Control(6) <= RFormat;
	Control(7) <= beq;	
	
end Dataflow;