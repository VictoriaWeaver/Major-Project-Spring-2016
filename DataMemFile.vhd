----------------------------------------------------------------------------------
-- File:			DataMemFile.vhd
-- 
-- Entity:			DataMemFile
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

entity DataMemFile is
	Port ( 	DataIn 	: in STD_LOGIC_VECTOR(31 downto 0); 
			RST 	: in STD_LOGIC;
           	CLK 	: in STD_LOGIC;
           	RE 		: in STD_LOGIC;
           	WE 		: in STD_LOGIC;
           	address	: in STD_LOGIC_VECTOR(31 downto 0);
           	output 	: out STD_LOGIC_VECTOR(31 downto 0));
end DataMemFile;

architecture Behavioral of DataMemFile is

signal op: STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";

type memory is array (0 to 9) of bit_vector(31 downto 0);
variable MEM : memory :=
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
	output <= op;
	-- Reset to zero
	if (RST = '1') then
		op <= (others => '0');
	-- Module must be enabled to change
	elsif (CLK='1' and CLK'EVENT and RE='1') then
		if (WE = '1') then
			op <= DataIn;
			memory(address(3 downto 0)) <= DataIn;
		else
			with address(3 downto 0) select op <=
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
		end if;
	else
		op <= op;	-- No change in output
	end if;
end process;


end Behavioral;

