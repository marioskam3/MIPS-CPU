library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;


entity tb_mips is
end tb_mips;

architecture bhv of tb_mips is
  
  component MIPS port (reset  : in std_logic;
                       clk : in std_logic
                       );
                       
  end component;
  
signal clock : std_logic;
signal rst : std_logic;

begin 
  cpu: mips port map (reset=>rst,clk=>clock);
    
    process --reset
    begin
    reset1 <= '1';
    wait for 50 ns;
    reset1 <= '0';
    wait for 50 ns;
    end process;
    
    process
      variable clktmp : std_logic:='1';
      variable rst1 : std_logic:='1';
    begin
      clktmp:= not clktmp;
      clock<=clktmp;
      if (rst1 = '1') then 
          rst<=rst1;
          rst1:='0';
        else 
          rst<='0';
      end if;
      wait for 50 ns;
    end process;
end bhv; 
       