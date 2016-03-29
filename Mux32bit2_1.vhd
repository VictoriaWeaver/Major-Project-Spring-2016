-----------------------------------------------------------------
-- File:				Mux32bit2_1.vhd
-- 
-- Entity:			Mux32bit2_1
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

entity Mux32bit2_1 is
	Port (	S 		: in  STD_LOGIC;
           	W0,W1 : in  STD_LOGIC_VECTOR(31 downto 0);
           	Z 		: out  STD_LOGIC_VECTOR(31 downto 0));
end Mux32bit2_1;

architecture Dataflow of Mux32bit2_1 is

begin
	Z <= 	W0 when (S = '0') else
			W1;
			

end Dataflow;

