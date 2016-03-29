----------------------------------------------------------------------------------
-- File:			Fetch.vhd
-- 
-- Entity:			Fetch
-- Architecture:	Structural
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
-- 					the fetch logic for the MIPS ISA.
----------------------------------------------------------------------------------
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

entity Fetch is
	Port( WE 	: in STD_LOGIC;
			CLK 	: in STD_LOGIC;
			RST 	: in STD_LOGIC;
			ADDR 	: out STD_LOGIC_VECTOR(31 downto 0));
end Fetch;



architecture Structural of Fetch is
--Components

-- RegisterModule:	The register file contains 32 n-bit 
-- 					32:1 register modules.
component RegisterModule
	Generic ( n : integer:=32);
    Port ( X 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           WE 	: in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           RST 	: in  STD_LOGIC;
           Z 	: out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;


-- Adder module
component Adder
	Port ( 	Input1 : in  STD_LOGIC_VECTOR(31 downto 0);
				Input2 : in  STD_LOGIC_VECTOR(31 downto 0);
           	Output : out  STD_LOGIC_VECTOR(31 downto 0));
end component;


constant INCREMENT : STD_LOGIC_VECTOR(31 downto 0) := std_logic_vector(to_unsigned(4, 32));
signal INTERMEDIATE : STD_LOGIC_VECTOR(31 downto 0);
signal address :  STD_LOGIC_VECTOR(31 downto 0);

begin

PC:	RegisterModule port map(INTERMEDIATE, WE, CLK, RST, address);

Add4: Adder port map(INCREMENT, address, INTERMEDIATE);

ADDR <= address;
 
end Structural;


