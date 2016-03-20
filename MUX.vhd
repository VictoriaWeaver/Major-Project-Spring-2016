----------------------------------------------------------------------------------
-- File:			MUX.vhd
-- 
-- Entity:			MUX
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
-- 					an	n-bit 2:1 multiplexer.
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

entity MUX is
	Generic( n : integer );
    Port (	S 		: in  STD_LOGIC;
           	W0,W1 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           	Z 		: out  STD_LOGIC_VECTOR(n-1 downto 0));
end MUX;


-- The multiplexer takes 32 n-bit inputs and uses a 3-bit select signal to select 
-- which input goes to the output. 
architecture Dataflow of MUX is

begin
	Z <= 	W0 when (S = 0) else
			W1;
			

end Dataflow;

