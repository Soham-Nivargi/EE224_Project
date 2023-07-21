library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter7 is
  port ( a : in std_logic_vector(15 downto 0); s : out std_logic_vector(15 downto 0));
end entity shifter7;

architecture Struct of shifter7 is

  
begin 

s(15 downto 7) <= a(8 downto 0);
s(6 downto 0) <= "0000000";


end Struct;