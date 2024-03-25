library IEEE;
use IEEE.std_logic_1164.ALL;

entity Mux5bit is
    
    port ( input1  : in  std_logic_vector(4 downto 0);
           input2  : in  std_logic_vector(4 downto 0);
	         select1 : in  std_logic;
           output  : out std_logic_vector(4 downto 0));

end Mux5bit;

architecture behavioral of Mux5bit is

begin

process(select1,input1,input2)

begin

if select1 = '0' then
 	output <= input1;

elsif select1 = '1' then
	output <= input2;

end if;

end process;

end behavioral;
