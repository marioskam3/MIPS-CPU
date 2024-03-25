library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity SignExtend is
    port ( input  : in  std_logic_vector (15 downto 0);
           output : out std_logic_vector (31 downto 0)
         );
end SignExtend;

architecture behavioral of SignExtend is

begin

	Output <= std_logic_vector(resize(signed(Input), Output'length));

end behavioral;
