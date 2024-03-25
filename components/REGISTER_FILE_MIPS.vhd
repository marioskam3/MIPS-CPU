library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL; 

entity RegisterFile is
  
  Port ( ReadRegister1 : in std_logic_vector (4 downto 0);
         ReadRegister2 : in std_logic_vector (4 downto 0);
         WriteRegister : in std_logic_vector (4 downto 0);
         WriteData     : in std_logic_vector (31 downto 0);
         RegWrite      : in std_logic;
         ReadData1     : out std_logic_vector (31 downto 0);
         ReadData2     : out std_logic_vector (31 downto 0)
        );
       
end RegisterFile;

architecture behavioral of RegisterFile is 

  
  type reg_type is array (0 to 2**5-1 ) of std_logic_vector (31 downto 0);

  signal array_reg : reg_type := (      x"00000000", 
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000", 
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
                                        x"00000000",
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
  process(RegWrite)
    begin
      if ( RegWrite = '1' ) then
        array_reg(to_integer(unsigned(WriteRegister))) <= WriteData;
      end if;
    end process;
  
    ReadData1 <= array_reg(to_integer(unsigned(ReadRegister1)));
    ReadData2 <= array_reg(to_integer(unsigned(ReadRegister2)));
   
                                      
end behavioral;
                                        
                                        
                                        