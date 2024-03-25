library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pcAdder is
     port ( X: in std_logic_vector(31 downto 0);
	          Z: out std_logic_vector(31 downto 0)
	        );
end pcAdder;

architecture behavioral of pcAdder is
   begin
        Z <= X+4;
end behavioral;
