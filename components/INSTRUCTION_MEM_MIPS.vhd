library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
--ROM
entity InstructionMemory is
   port ( ReadAddress : in std_logic_vector (31 downto 0);
          Instruction : out std_logic_vector  (31 downto 0)
        );
end InstructionMemory;

architecture behavioral of InstructionMemory is 

  type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);

  signal IM : RAM_16_x_32 := ( x"20030001",
                               x"20050003",
                               x"AC860000",
                               x"20630001",
                               x"20840001",
                               x"20A5FFFF",
                               x"14A0fffA",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000" );

begin
  
  Instruction <= x"00000000" when ReadAddress = x"003FFFFC" else
            IM( (to_integer(unsigned(ReadAddress))- 4194304)/4 );


end behavioral;
