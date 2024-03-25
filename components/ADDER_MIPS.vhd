library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
    port ( X,Y : in std_logic_vector(31 downto 0);
	         Z   : out std_logic_vector(31 downto 0)
	         );
end adder;

architecture behavioral of adder is
begin
    Z <= X+Y;
end behavioral;
