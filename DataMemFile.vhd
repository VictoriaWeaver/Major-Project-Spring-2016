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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

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
	output <= op;
	-- Reset to zero
	if (RST = '1') then
		op <= (others => '0');
	-- Module must be enabled to change
	elsif (CLK='1' and CLK'EVENT and RE='1') then
		if (WE = '1') then
			op <= DataIn;
			MEM(to_integer(unsigned(address(3 downto 0)))) := DataIn;
		else
			case address(3 downto 0) is
				when "0000" => op <= MEM(0);
				when "0001" => op <= MEM(1);
				when "0010" => op <= MEM(2);
				when "0011" => op <= MEM(3);
				when "0100" => op <= MEM(4);
				when "0101" => op <= MEM(5);
				when "0110" => op <= MEM(6);
				when "0111" => op <= MEM(7);
				when "1000" => op <= MEM(8);
				when "1001" => op <= MEM(9);				
				when others => op <= "00000000000000000000000000000000";		
			end case;
		end if;
	else
		op <= op;	-- No change in output
	end if;
end process;


end Behavioral;

