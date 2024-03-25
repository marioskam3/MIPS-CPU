library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity MIPS is
    port ( reset : in std_logic;
           clk   : in std_logic
          );
end MIPS;

architecture structural of MIPS is
  
--ALU
component ALU
  port ( clk        : in std_logic;
         Input1     : in std_logic_vector(31 downto 0);
         Input2     : in std_logic_vector(31 downto 0);
         Shamt      : in std_logic_vector(4 downto 0);
         aluControl : in std_logic_vector(3 downto 0);
         zeroBit    : out std_logic;
         aluResult  : out std_logic_vector(31 downto 0) 
       );
end component;

--Register File
component RegisterFile
  port ( ReadRegister1 : in std_logic_vector (4 downto 0);
         ReadRegister2 : in std_logic_vector (4 downto 0);
         WriteRegister : in std_logic_vector (4 downto 0);
         WriteData     : in std_logic_vector (31 downto 0);
         RegWrite      : in std_logic;
         ReadData1     : out std_logic_vector (31 downto 0);
         ReadData2     : out std_logic_vector (31 downto 0) 
       );
end component;

--DATA MEMORY
component DataMemory
  port ( Address   : in std_logic_vector (31 downto 0);
         WriteData : in std_logic_vector (31 downto 0);
         MemRead   : in std_logic;
         MemWrite  : in std_logic;
         ReadData  : out std_logic_vector (31 downto 0)
       );
end component;

--INSTRUCTION MEM
component InstructionMemory
  port ( ReadAddress : in std_logic_vector (31 downto 0);
        Instruction : out std_logic_vector  (31 downto 0)
       );
end component;

--CONTROL UNIT
component control
  port ( Instr    : in std_logic_vector(5 downto 0);
         RegDst   : out std_logic;
         Branch   : out std_logic;
         MemRead  : out std_logic;
         MemtoReg : out std_logic;
         MemWrite : out std_logic;
         ALUSrc   : out std_logic;
         RegWrite : out std_logic;
         ALUOp    : out std_logic_vector(1 downto 0)
       );
end component;

--ALU CONTROL
component aluControl
  port ( clk             : in std_logic;
         aluOp           : in std_logic_vector(1 downto 0); 
         Instruction     : in std_logic_vector(5 downto 0); 
         aluControlInstr : out std_logic_vector(3 downto 0)
       );
end component;

--PROGRAM COUNTER
component ProgramCounter
  port (   clk    : in  std_logic;
           input  : in  std_logic_vector (31 downto 0);
           reset  : in  std_logic;
           output : out  std_logic_vector (31 downto 0)
       );
end component;


--MUX5bit
component Mux5bit
  port (   input1  : in  std_logic_vector(4 downto 0);
           input2  : in  std_logic_vector(4 downto 0);
	         select1 : in  std_logic;
           output  : out std_logic_vector(4 downto 0)
       );
end component;

--SIGN EXTENDER
component SignExtend
  port ( input  : in  std_logic_vector (15 downto 0);
         output : out std_logic_vector (31 downto 0) 
       );
end component;

--MUX32bit
component Mux32bit
  port ( input1  : in   std_logic_vector(31 downto 0);
         input2  : in   std_logic_vector(31 downto 0);
	       select1 : in   std_logic;
         output  : out  std_logic_vector(31 downto 0) 
       );
end component;

--SHIFT REG
component shiftLeft
  port ( input  : in  STD_LOGIC_VECTOR (31 downto 0);           
	       output : out STD_LOGIC_VECTOR(31 downto 0)
       );
end component;

--PC ADDER
component pcAdder
  port ( X: in std_logic_vector(31 downto 0);
	       Z: out std_logic_vector(31 downto 0)
       );
end component;

--ADDER
component adder
  port ( X,Y : in std_logic_vector(31 downto 0);
	       Z   : out std_logic_vector(31 downto 0)
       );
end component;

--SIGNALS (cables)

--PC
signal pcoutput : std_logic_vector(31 downto 0);

--datamem
signal memoryOut : std_logic_vector(31 downto 0);

--instruct mem 
signal instruction_output : std_logic_vector(31 downto 0);

--registerfile 
signal registerRead1 : std_logic_vector (31 downto 0);
signal registerRead2 : std_logic_vector (31 downto 0);

--ALUControl
signal aluControlOut : std_logic_vector(3 downto 0);

--ALU
signal aluResultOut : std_logic_vector(31 downto 0);
signal aluZeroOut : std_logic;

--Control U
signal RegDst   : std_logic;
signal Branch   : std_logic;
signal MemRead  : std_logic;
signal MemtoReg : std_logic;
signal MemWrite : std_logic;
signal ALUSrc   : std_logic;
signal RegWrite : std_logic;
signal ALUOp    : std_logic_vector(1 downto 0);

--extender
signal signexout : std_logic_vector (31 downto 0);

--shift
signal shiftout: std_logic_vector ( 31 downto 0);

--adder
signal oadder : std_logic_vector(31 downto 0);

--adder2
signal oadder2 : STD_LOGIC_VECTOR (31 downto 0);

--MUX OUTPUTS
--32 bits
signal omux1 : std_logic_vector(31 downto 0);
signal omux2 : std_logic_vector(31 downto 0);
signal omux3 : std_logic_vector(31 downto 0);
signal sig :std_logic;
--5 bits
signal omux4 : std_logic_vector(4 downto 0);

begin 
  pc: ProgramCounter port map (clk,omux2,reset,pcoutput);
  
  pcAdd: pcAdder port map (pcoutput,oadder);
  
  instmem: InstructionMemory port map (pcoutput,instruction_output);
    
  cu: control port map (instruction_output( 31 downto 26),RegDst,Branch,MemRead,MemtoReg,MemWrite,AluSrc,RegWrite,ALUOp);
  
  mux_intr_reg: Mux5bit port map (instruction_output( 20 downto 16),instruction_output( 15 downto 11),RegDst,omux4);
    
  reg: RegisterFile port map (instruction_output( 25 downto 21),instruction_output( 20 downto 16),omux4,omux2,RegWrite,registerRead1,registerRead2);
  
  se: SignExtend port map (instruction_output(15 downto 0),signexout);
  
  mux_reg_alu: Mux32bit port map (registerRead2,signexout,ALUSrc,omux3);
    
  aluc: aluControl port map (clk,ALUOp,instruction_output(5 downto 0),aluControlout);
  
  shleft: shiftLeft port map (signexout,shiftout);
  
  add: adder port map (oadder,shiftout,oadder2);
    
  al: ALU port map (clk,registerRead1,omux3,instruction_output (10 downto 6),aluControlout,aluZeroOut,aluResultOut);
   
  pcmux: Mux32bit port map (oadder,oadder2,sig,omux1);
   
  mem: DataMemory port map (aluResultOut,registerRead2,MemRead,MemWrite,memoryOut);
    
  mux_mem_reg: Mux32bit port map (aluResultOut,memoryOut,MemtoReg,omux2);
  
    
   
end structural;















