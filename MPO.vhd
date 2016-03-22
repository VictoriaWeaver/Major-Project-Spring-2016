Fetch Logic (Fetch.vhd)

Register Files: (RegisterFile.vhd)
	instruction mem
	registers
	data mem

ALU-

OpCode Logic

Multiplexers (32-bit, 2:1) (MUX.vhd)


-----------------------------------------
entity ISA is
	Port();
end ISA;

architecture Structural of ISA is

-- Control Signals
signal RegDst : STD_LOGIC;
signal MemRead : STD_LOGIC;
signal MemtoReg : STD_LOGIC;
signal ALUOp : STD_LOGIC;
signal MemWrite : STD_LOGIC;
signal ALUSrc: STD_LOGIC;
signal RegWrite : STD_LOGIC;

-- Components

-- Fetch Logic
component Fetch
	Port( 	WE 		: in STD_LOGIC;
			CLK 	: in STD_LOGIC;
			RST 	: in STD_LOGIC;
			ADDR 	: out STD_LOGIC_VECTOR(31 downto 0));
end component;

-- Register File
component RegisterFile
	Generic( n: integer := 32);
    Port (	rd1 	: in  STD_LOGIC_VECTOR(2 downto 0);
           	rd2 	: in  STD_LOGIC_VECTOR(2 downto 0);
           	rst 	: in  STD_LOGIC;
           	clk 	: in  STD_LOGIC;
           	wr 		: in  STD_LOGIC_VECTOR(4 downto 0);
           	we 		: in  STD_LOGIC;
			input 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           	out1 	: out  STD_LOGIC_VECTOR(n-1 downto 0);
           	out2 	: out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- MUX (2:1 multiplexer)
component MUX
	Generic( n : integer );
    Port (	S 		: in  STD_LOGIC;
           	W0,W1 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
           	Z 		: out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;


begin

-- fetchInstruction : Fetch port map (WE, CLK, RST, ADDR);

-- mux1 : MUX port map(ALUSrc, RegReadData2, Inst(15 downto 0), ALUIn2);
-- mux2 : MUX port map(MemtoReg, ALUResult, DataMemRead, WriteData);


end Structural;
