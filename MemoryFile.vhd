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
--					a 32-bit address memory file.
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
           	output 	: out  STD_LOGIC_VECTOR(31 downto 0));
end MemoryFile;

architecture Behavioral of MemoryFile is

type memory is array (0 to 9) of std_logic_vector(31 downto 0);
shared variable MEM : memory :=
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
		case address(3 downto 0) is
				when "0000" => output <= MEM(0);
				when "0001" => output <= MEM(1);
				when "0010" => output <= MEM(2);
				when "0011" => output <= MEM(3);
				when "0100" => output <= MEM(4);
				when "0101" => output <= MEM(5);
				when "0110" => output <= MEM(6);
				when "0111" => output <= MEM(7);
				when "1000" => output <= MEM(8);
				when "1001" => output <= MEM(9);				
				when others => output <= "00000000000000000000000000000000";		
			end case;
	else
		-- Do nothing
	end if;
end process;


end Behavioral;

