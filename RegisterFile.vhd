----------------------------------------------------------------------------------
-- File:			RegisterFile.vhd
-- 
-- Entity:			RegisterFile
-- Architecture:			Structural
-- Author:			Victoria Weaver
-- Created:			3/20/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
--					an n-bit register file of size 32 (32 registers).
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

entity RegisterFile is
	Generic( n: integer := 32);
    Port (	rd1 	: in  STD_LOGIC_VECTOR(4 downto 0);
           	rd2 	: in  STD_LOGIC_VECTOR(4 downto 0);
           	rst 	: in  STD_LOGIC;
           	clk 	: in  STD_LOGIC;
           	wr 		: in  STD_LOGIC_VECTOR(4 downto 0);
           	we 		: in  STD_LOGIC;
			input 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           	out1 	: out  STD_LOGIC_VECTOR(n-1 downto 0);
           	out2 	: out  STD_LOGIC_VECTOR(n-1 downto 0));
end RegisterFile;

architecture Structural of RegisterFile is

-- Components 

-- Decoder:  The register file contains a single 5:32 decoder.
component Decoder
	Port ( 	X : in  STD_LOGIC_VECTOR(4 downto 0);
          	Z : out  STD_LOGIC_VECTOR(31 downto 0));
end component;


-- Multiplexer:	The register file contains two n-bit 32:1 multiplexers.
component Multiplexer
	Generic ( n: integer );
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
end component;


-- RegisterModule:	The register file contains 32 n-bit 
-- 					32:1 register modules.
component RegisterModule
	Generic ( n : integer);
    Port ( X 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           WE 	: in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           RST 	: in  STD_LOGIC;
           Z 	: out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;


-- Signals
signal decode_out: STD_LOGIC_VECTOR(31 downto 0);	-- Output of the decoder 

signal rout0, rout1, rout2, rout3, rout4, rout5, rout6, rout7: STD_LOGIC_VECTOR(n-1 downto 0);			-- The output of the register modules
signal rout8, rout9, rout10, rout11, rout12, rout13, rout14, rout15: STD_LOGIC_VECTOR(n-1 downto 0);	-- The output of the register modules
signal rout16, rout17, rout18, rout19, rout20, rout21, rout22, rout23: STD_LOGIC_VECTOR(n-1 downto 0);	-- The output of the register modules
signal rout24, rout25, rout26, rout27, rout28, rout29, rout30, rout31: STD_LOGIC_VECTOR(n-1 downto 0);	-- The output of the register modules

signal ren0, ren1, ren2, ren3, ren4, ren5, ren6, ren7: STD_LOGIC; 			-- The combined enable of the register modules with the file enable
signal ren8, ren9, ren10, ren11, ren12, ren13, ren14, ren15: STD_LOGIC; 	-- The combined enable of the register modules with the file enable
signal ren16, ren17, ren18, ren19, ren20, ren21, ren22, ren23: STD_LOGIC; 	-- The combined enable of the register modules with the file enable
signal ren24, ren25, ren26, ren27, ren28, ren29, ren30, ren31: STD_LOGIC; 	-- The combined enable of the register modules with the file enable


begin
	--Single decoder
	decode: Decoder port map(wr, decode_out);	-- No generics
	
	-- Each register is enabled iff the file is enables and the decoder selects the module
	ren0 <= (we AND decode_out(0));
	ren1 <= (we AND decode_out(1));
	ren2 <= (we AND decode_out(2));
	ren3 <= (we AND decode_out(3));
	ren4 <= (we AND decode_out(4));
	ren5 <= (we AND decode_out(5));
	ren6 <= (we AND decode_out(6));
	ren7 <= (we AND decode_out(7));
	ren8 <= (we AND decode_out(8));
	ren9 <= (we AND decode_out(9));
	ren10 <= (we AND decode_out(10));
	ren11 <= (we AND decode_out(11));
	ren12 <= (we AND decode_out(12));
	ren13 <= (we AND decode_out(13));
	ren14 <= (we AND decode_out(14));
	ren15 <= (we AND decode_out(15));
	ren16 <= (we AND decode_out(16));
	ren17 <= (we AND decode_out(17));
	ren18 <= (we AND decode_out(18));
	ren19 <= (we AND decode_out(19));
	ren20 <= (we AND decode_out(20));
	ren21 <= (we AND decode_out(21));
	ren22 <= (we AND decode_out(22));
	ren23 <= (we AND decode_out(23));
	ren24 <= (we AND decode_out(24));
	ren25 <= (we AND decode_out(25));
	ren26 <= (we AND decode_out(26));
	ren27 <= (we AND decode_out(27));
	ren28 <= (we AND decode_out(28));
	ren29 <= (we AND decode_out(29));
	ren30 <= (we AND decode_out(30));
	ren31 <= (we AND decode_out(31));
	
	
	-- 32 register modules
	R0: RegisterModule
		generic map (n => n)
		port map(input, ren0, clk, rst, rout0);
	R1: RegisterModule 
		generic map (n => n)
		port map(input, ren1, clk, rst, rout1);
	R2: RegisterModule 
		generic map (n => n)
		port map(input, ren2, clk, rst, rout2);
	R3: RegisterModule 
		generic map (n => n)
		port map(input, ren3, clk, rst, rout3);
	R4: RegisterModule 
		generic map (n => n)
		port map(input, ren4, clk, rst, rout4);
	R5: RegisterModule 
		generic map (n => n)
		port map(input, ren5, clk, rst, rout5);
	R6: RegisterModule 
		generic map (n => n)
		port map(input, ren6, clk, rst, rout6);
	R7: RegisterModule 
		generic map (n => n)
		port map(input, ren7, clk, rst, rout7);
	R8: RegisterModule 
		generic map (n => n)
		port map(input, ren8, clk, rst, rout8);
	R9: RegisterModule 
		generic map (n => n)
		port map(input, ren9, clk, rst, rout9);
	R10: RegisterModule 
		generic map (n => n)
		port map(input, ren10, clk, rst, rout10);
	R11: RegisterModule 
		generic map (n => n)
		port map(input, ren11, clk, rst, rout11);
	R12: RegisterModule 
		generic map (n => n)
		port map(input, ren12, clk, rst, rout12);
	R13: RegisterModule 
		generic map (n => n)
		port map(input, ren13, clk, rst, rout13);
	R14: RegisterModule 
		generic map (n => n)
		port map(input, ren14, clk, rst, rout14);
	R15: RegisterModule 
		generic map (n => n)
		port map(input, ren15, clk, rst, rout15);
	R16: RegisterModule 
		generic map (n => n)
		port map(input, ren16, clk, rst, rout16);
	R17: RegisterModule 
		generic map (n => n)
		port map(input, ren17, clk, rst, rout17);
	R18: RegisterModule 
		generic map (n => n)
		port map(input, ren18, clk, rst, rout18);
	R19: RegisterModule 
		generic map (n => n)
		port map(input, ren19, clk, rst, rout19);
	R20: RegisterModule 
		generic map (n => n)
		port map(input, ren20, clk, rst, rout20);
	R21: RegisterModule 
		generic map (n => n)
		port map(input, ren21, clk, rst, rout21);
	R22: RegisterModule 
		generic map (n => n)
		port map(input, ren22, clk, rst, rout22);
	R23: RegisterModule 
		generic map (n => n)
		port map(input, ren23, clk, rst, rout23);
	R24: RegisterModule 
		generic map (n => n)
		port map(input, ren24, clk, rst, rout24);
	R25: RegisterModule 
		generic map (n => n)
		port map(input, ren25, clk, rst, rout25);
	R26: RegisterModule 
		generic map (n => n)
		port map(input, ren26, clk, rst, rout26);
	R27: RegisterModule 
		generic map (n => n)
		port map(input, ren27, clk, rst, rout27);
	R28: RegisterModule 
		generic map (n => n)
		port map(input, ren28, clk, rst, rout28);
	R29: RegisterModule 
		generic map (n => n)
		port map(input, ren29, clk, rst, rout29);
	R30: RegisterModule 
		generic map (n => n)
		port map(input, ren30, clk, rst, rout30);
	R31: RegisterModule 
		generic map (n => n)
		port map(input, ren31, clk, rst, rout31);
	


	
	-- Two multiplexers
	mux1: Multiplexer 
		generic map (n => n)
		port map(rd1, 
				rout0, rout1, rout2, rout3, rout4, rout5, rout6, rout7,
				rout8, rout9, rout10, rout11, rout12, rout13, rout14, rout15,
				rout16, rout17, rout18, rout19, rout20, rout21, rout22, rout23,
				rout24, rout25, rout26, rout27, rout28, rout29, rout30, rout31,
				out1);
	mux2: Multiplexer 
		generic map (n => n)
		port map(rd2, 
				rout0, rout1, rout2, rout3, rout4, rout5, rout6, rout7,
				rout8, rout9, rout10, rout11, rout12, rout13, rout14, rout15,
				rout16, rout17, rout18, rout19, rout20, rout21, rout22, rout23,
				rout24, rout25, rout26, rout27, rout28, rout29, rout30, rout31,
				out2);

end Structural;

