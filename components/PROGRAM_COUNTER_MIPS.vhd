library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter is
    port ( clk    : in  std_logic;
           input  : in  std_logic_vector (31 downto 0);
           reset  : in  std_logic;
           output : out  std_logic_vector (31 downto 0));
end ProgramCounter;

architecture behavioral of ProgramCounter is

begin

process(reset,clk)
  
begin
    if reset='1' then
       output <= (others=>'0');
    else
       if clk='1' and clk'event then
             output<=input;
       end if;
    end if;  
  end process;
  
end behavioral;
