----------------------------------------------------------------------------------
-- File:			ISA.vhd
-- 
-- Entity:			ISA
-- Architecture:	Structural
-- Author:			Victoria Weaver
-- Created:			3/22/16
-- Modified:		
-- 
-- VHDL '93
-- Descritption:	The following is the entity and architectural description of 
--					some of the isntructions of the MIPS Instruction Set 
--					Architecture
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

entity ISA is
	Port(
		RST 	: in STD_LOGIC;
		CLK 	: in STD_LOGIC;
		Zero 	: out STD_LOGIC);
end ISA;

architecture Structural of ISA is

-- Control Signals
signal opcode : STD_LOGIC_VECTOR(7 downto 0); 

signal RegDst : STD_LOGIC;
signal MemRead : STD_LOGIC;
signal MemtoReg : STD_LOGIC;
signal ALUOp : STD_LOGIC_VECTOR(1 downto 0);
signal MemWrite : STD_LOGIC;
signal ALUSrc: STD_LOGIC;
signal RegWrite : STD_LOGIC;

--Fetch Signals
signal PCInst : STD_LOGIC_VECTOR(31 downto 0);
signal Inst : STD_LOGIC_VECTOR(31 downto 0);


-- Register Signals
signal ReadData1	: STD_LOGIC_VECTOR(31 downto 0);
signal ReadData2 	: STD_LOGIC_VECTOR(31 downto 0);
signal WriteReg  	: STD_LOGIC_VECTOR(4 downto 0);
signal WriteData 	: STD_LOGIC_VECTOR(31 downto 0);


-- Memory Signals
signal ReadDataMem 	: STD_LOGIC_VECTOR(31 downto 0);

-- ALU Signals
signal ALUResult 	: STD_LOGIC_VECTOR(31 downto 0);
signal ALUIn2	  	: STD_LOGIC_VECTOR(31 downto 0);
signal ALUCont	 	: STD_LOGIC_VECTOR(3 downto 0);

--ALUControls
signal func	: STD_LOGIC_VECTOR(5 downto 0);

--Registers
signal rs 	: STD_LOGIC_VECTOR(4 downto 0);
signal rt 	: STD_LOGIC_VECTOR(4 downto 0);
signal rd 	: STD_LOGIC_VECTOR(4 downto 0);

-- Sign extend
signal ExtInst	: STD_LOGIC_VECTOR(31 downto 0);


signal ground : STD_LOGIC_VECTOR(31 downto 0);

-- Components

component OPCodeController
	Port(	func 		: in STD_LOGIC_VECTOR(5 downto 0);		
			Control	: out STD_LOGIC_VECTOR(7 downto 0));
end component;

-- Fetch Logic
component Fetch
	Port( WE 	: in STD_LOGIC;
			CLK 	: in STD_LOGIC;
			RST 	: in STD_LOGIC;
			ADDR 	: out STD_LOGIC_VECTOR(31 downto 0));
end component;

-- Register File
component RegisterFile
	Generic( n: integer := 32);
    Port (	rd1 	: in  STD_LOGIC_VECTOR(4 downto 0);
           	rd2 	: in  STD_LOGIC_VECTOR(4 downto 0);
           	rst 	: in  STD_LOGIC;
           	clk 	: in  STD_LOGIC;
           	wr 	: in  STD_LOGIC_VECTOR(4 downto 0);
           	we 	: in  STD_LOGIC;
				input : in  STD_LOGIC_VECTOR(n-1 downto 0);
           	out1 	: out  STD_LOGIC_VECTOR(n-1 downto 0);
           	out2 	: out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- Instruction Memory
component MemoryFile
	Port (	RST 		: in  STD_LOGIC;
           	CLK 		: in  STD_LOGIC;
           	address	: in  STD_LOGIC_VECTOR(31 downto 0);
           	output 	: out  STD_LOGIC_VECTOR(31 downto 0));
end component;


-- Data Memory
component DataMemFile
	Port ( 	DataIn 	: in STD_LOGIC_VECTOR(31 downto 0); 
				RST 		: in STD_LOGIC;
           	CLK 		: in STD_LOGIC;
           	RE 		: in STD_LOGIC;
           	WE 		: in STD_LOGIC;
           	address	: in STD_LOGIC_VECTOR(31 downto 0);
           	output 	: out STD_LOGIC_VECTOR(31 downto 0));
end component;


-- MUX (2:1 multiplexer)
component MUX
	Generic( n : integer:=5 );
   Port (S 			: in  STD_LOGIC;
         W0,W1 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
         Z 			: out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component Mux32bit2_1
	Port (	S 		: in  STD_LOGIC;
           	W0,W1 : in  STD_LOGIC_VECTOR(31 downto 0);
           	Z 		: out  STD_LOGIC_VECTOR(31 downto 0));
end component;

--ALU Component
component ALU is
	Port ( In1 			: in  STD_LOGIC_VECTOR(31 downto 0);
           In2 		: in  STD_LOGIC_VECTOR(31 downto 0);
           Control 	: in  STD_LOGIC_VECTOR(3 downto 0); 	-- 9 possible operations
           Output 	: out STD_LOGIC_VECTOR(31 downto 0);
           Zero 		: out STD_LOGIC);
end component;

component ALUControl is
	Port(	func 		: in STD_LOGIC_VECTOR(5 downto 0);
			ALUOp		: in STD_LOGIC_VECTOR(1 downto 0);
			Control	: out STD_LOGIC_VECTOR(3 downto 0));
end component;


begin

fetchInstruction : Fetch port map ('1', CLK, RST, PCInst);

-- Instruction Memory File
InstrMemFile: MemoryFile port map(RST, CLK, PCInst, Inst);

func <= Inst(31 downto 26);
opCodeControl : OPCodeController port map(func, opcode);


RegDst <= opcode(0);
ALUSrc <= opcode(1);
MemtoReg <= opcode(2);
RegWrite <= opcode(3);
MemRead <= opcode(4);
MemWrite <= opcode(5);
ALUOp <= opcode(7 downto 6);

rs <= Inst(25 downto 21);
rt <= Inst(20 downto 16);
rd <= Inst(15 downto 11);

-- MUX
mux1 : MUX port map(RegDst, rt, rd, WriteReg);

-- Register File
RegFile: RegisterFile port map(rs, rt, RST, CLK, WriteReg, RegWrite, WriteData, ReadData1, ReadData2);

ExtInst(15 downto 0) <= Inst(15 downto 0);
ExtInst(31 downto 16) <= "0000000000000000";

-- MUX
mux2 : Mux32bit2_1 port map(ALUSrc, ReadData2, ExtInst, ALUIn2);

-- ALU Control
ALUController: ALUControl port map(func, ALUOp, ALUCont);

-- ALU
ALUnit: ALU port map(ReadData1, ALUIn2, ALUCont, ALUResult, Zero);

-- Data Memory File
DataFile: DataMemFile port map(ReadData2, RST, CLK, MemRead, MemWrite, ALUResult, ReadDataMem);

-- MUX
mux3 : Mux32bit2_1 port map(MemtoReg, ALUResult, ReadDataMem, WriteData);

end Structural;














