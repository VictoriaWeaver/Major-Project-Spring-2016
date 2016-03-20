----------------------------------------------------------------------------------
-- File:			Multiplexer.vhd
-- 
-- Entity:			Multiplexer
-- Architecture:	Dataflow
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
-- 					an	n-bit 32:1 multiplexer.
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

entity Multiplexer is
	Generic( n : integer );
    Port ( S : in  STD_LOGIC_VECTOR(4 downto 0);
           W0,W1,W2,W3,
           W4,W5,W6,W7,
           W8,W9,W10,W11,
           W12,W13,W14,W15,
           W16,W17,W18,W19,
           W20,W21,W22,W23,
           W24,W25,W26,W27,
           W28,W29,W30,W31 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           Z : out  STD_LOGIC_VECTOR(n-1 downto 0));
end Multiplier;


-- The multiplexer takes 32 n-bit inputs and uses a 3-bit select signal to select 
-- which input goes to the output. 
architecture Dataflow of MUX is

begin
	Z <= 	W0 when (S = "00000") else
			W1 when (S = "00001") else
			W2 when (S = "00010") else
			W3 when (S = "00011") else
			W4 when (S = "00100") else
			W5 when (S = "00101") else
			W6 when (S = "00110") else
			W7 when (S = "00111") else
			W8 when (S = "01000") else
			W9 when (S = "01001") else
			W10 when (S = "01010") else
			W11 when (S = "01011") else
			W12 when (S = "01100") else
			W13 when (S = "01101") else
			W14 when (S = "01110") else
			W15 when (S = "01111") else
			W16 when (S = "10000") else
			W17 when (S = "10001") else
			W18 when (S = "10010") else
			W19 when (S = "10011") else
			W20 when (S = "10100") else
			W21 when (S = "10101") else
			W22 when (S = "10110") else
			W23 when (S = "10111") else
			W24 when (S = "11000") else
			W25 when (S = "11001") else
			W26 when (S = "11010") else
			W27 when (S = "11011") else
			W28 when (S = "11100") else
			W29 when (S = "11101") else
			W30 when (S = "11110") else
			W31;

end Dataflow;

