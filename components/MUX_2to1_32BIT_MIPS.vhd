library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux32bit is
    port ( input1  : in   std_logic_vector(31 downto 0);
           input2  : in   std_logic_vector(31 downto 0);
	         select1 : in   std_logic;
           output  : out  std_logic_vector(31 downto 0)
          );
end Mux32bit;

architecture behavioral of Mux32bit is
begin
  process(select1,input1,input2)
  begin

      if select1 = '0' then
 	 output <= input1;
	
      else 
	 output <= input2;
      end if;

  end process;
end behavioral;