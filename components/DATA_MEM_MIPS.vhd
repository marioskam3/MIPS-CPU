library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
  port ( Address   : in std_logic_vector (31 downto 0);
         WriteData : in std_logic_vector (31 downto 0);
         MemRead   : in std_logic;
         MemWrite  : in std_logic;
         ReadData  : out std_logic_vector (31 downto 0)
        );
end DataMemory;

architecture behavioral of DataMemory is
  
  type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);
  
  signal DM : RAM_16_x_32 := ( x"00000000",
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

  process(MemWrite, MemRead)
  begin
		if ( MemWrite = '1' ) then
			DM(   ( to_integer(unsigned(Address))- 268500992  )/4  ) <= WriteData;
		end if;
		
		if ( MemRead = '1' ) then
			ReadData <= DM(   ( to_integer(unsigned(Address))- 268500992  )/4  );
		end if;
	end process;

end behavioral;
