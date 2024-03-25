library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.numeric_std.all;

entity ALU is 
  port ( clk        : in std_logic;
         Input1     : in std_logic_vector(31 downto 0);
         Input2     : in std_logic_vector(31 downto 0);
         Shamt      : in std_logic_vector(4 downto 0);
         aluControl : in std_logic_vector(3 downto 0);
         zeroBit    : out std_logic;
         aluResult  : out std_logic_vector(31 downto 0)
        );
      end ALU;
      
architecture behavioral of ALU is
begin
  process (clk)
    variable temp1: integer:=0;
    variable temp2: integer:=0;
    
  begin
    if clk='1' and clk'event then 
      case aluControl is
       
      when "0000" =>
        zeroBit <= '0'; aluResult <= Input1 and Input2;
        
      when "0001" =>
        zeroBit <= '0'; aluResult <= Input1 or Input2;
        
      when "0010" =>
        temp1:=to_integer(signed(Input1)+signed(Input2));
	      zeroBit<='0';aluResult<=std_logic_vector(to_signed(temp1,32));
	      
	    when "0011"=>
	      temp1:=to_integer(signed(Shamt));
	      zeroBit<='0';aluResult<=std_logic_vector(signed(Input2) sll temp1);
	      
	    when "0100"=>
	      temp1:=to_integer(signed(Shamt));
	      zeroBit<='0';aluResult<=std_logic_vector(signed(Input2) srl temp1);
	      
	    when "0101"=>
	      zeroBit<='0';aluResult<=Input1 nor Input2;
	      
	    when "0110"=>
	      temp1:=to_integer(signed(Input1)-signed(Input2));
	      if temp1=0 then zeroBit<='1'; else zeroBit<='0'; end if;
	      temp1:=to_integer(signed(Input1)-signed(Input2));
	      aluResult<=std_logic_vector(to_signed(temp1,32));
	     
	    when "0111"=>
	     if signed(Input1)<signed(Input2) then aluResult<=(0 downto 0=>'1',others=>'0'); else aluResult<=(others=>'0'); end if;
	     zeroBit<='0';
	    
	    when "1111"=>
	     temp1:=to_integer(signed(Input1)-signed(Input2));
	     if temp1=0 then zeroBit<='0'; else zeroBit<='1'; end if;
	     aluResult<=Input1 and Input2;
	     
	    when "1000"=>
	     temp1:=to_integer(signed(Input1)-signed(Input2));
	     if temp1=0 then zeroBit<='1'; else zeroBit<='0'; end if;
	     aluResult<=Input1 or Input2;
	     
	    when others=>
	     zeroBit<='0';aluResult<=(others=>'0');
	
	    end case;

    end if;

  end process;

end Behavioral;
	    
	      
	      