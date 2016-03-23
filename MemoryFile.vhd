----------------------------------------------------------------------------------
-- File:			MemoryFile.vhd
-- 
-- Entity:			MemoryFile
-- Architecture:	Behavioral
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
--					a word-addressable memory file.
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

entity MemoryFile is
	Port ( 	RST 	: in  STD_LOGIC;
           	CLK 	: in  STD_LOGIC;
           	address	: in  STD_LOGIC_VECTOR(31 downto 0);
           	output 	: out  STD_LOGIC_VECTOR(31 downto 0);
end MemoryFile;

architecture Behavioral of MemoryFile is

type memory is array (0 to 9) of bit_vector(31 downto 0);
constant MEM : memory :=
            	("00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000",
            	"00000000000000000000000000000000");		-- initialized with No-op instructions
begin

P1: process(RST,CLK)
begin
	-- Reset to zero
	if (RST = '1') then
		output <= (others => '0');
	-- Module must be enabled to change
	elsif (CLK='1' and CLK'EVENT) then
		with address(3 downto 0) select output <=
			memory(0) when "0000",
			memory(1) when "0001",
			memory(2) when "0010",
			memory(3) when "0011",
			memory(4) when "0100",
			memory(5) when "0101",
			memory(6) when "0110",
			memory(7) when "0111",
			memory(8) when "1000",
			memory(9) when "1001",
			"00000000000000000000000000000000" when others; 	-- No-op
	else
		-- Do nothing
	end if;
end process;


end Behavioral;

