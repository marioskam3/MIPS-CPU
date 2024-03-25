library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity shiftLeft is
    port ( input  : in  STD_LOGIC_VECTOR (31 downto 0);           
	         output : out STD_LOGIC_VECTOR(31 downto 0)
	        );			  
end shiftLeft;

architecture behavioral of shiftLeft is
begin
	output <=  std_logic_vector(unsigned(input) sll 2);
end behavioral;

