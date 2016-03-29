----------------------------------------------------------------------------------
-- File:			RegisterModule.vhd
-- 
-- Entity:			RegisterModule
-- Architecture:	Behavioral
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
-- 					an	n-bit register module.
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

entity RegisterModule is
	Generic ( n : integer:= 32 );
    Port ( X 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           WE 	: in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           RST 	: in  STD_LOGIC;
           Z 	: out  STD_LOGIC_VECTOR(n-1 downto 0));
end RegisterModule;


-- The register module outputs the n-bit input of the register on the rising edge 
-- of the clock iff enabled.  
-- If the reset signal is high, the output of the is set to all zeros
architecture Behavioral of RegisterModule is
begin
P1: process(RST,CLK,WE)
begin
	-- Reset to zero
	if (RST = '1') then
		Z <= (others => '0');
	-- Module must be enabled to change
	else 
		if (WE = '1' and CLK'EVENT and CLK='1') then
			Z <= X;
		end if;
	end if;
end process;

end Behavioral;

