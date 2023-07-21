library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu is
port(clock, reset: in std_logic;
	output_test: out std_logic);
end entity;

architecture main of cpu is

component statetransition is 
	port(C, Z, eq, loopcondn, clk, rst : in std_logic;
			opcode : in std_logic_vector(3 downto 0);
			condition : in std_logic_vector(1 downto 0);
			states : out std_logic_vector(4 downto 0));
end component;

component structure is 
     port(state : in std_logic_vector(4 downto 0);
			clk : in std_logic;
			rst : in std_logic;
			opcode : out std_logic_vector(3 downto 0);
			loopcondn: out std_logic;
			condition: out std_logic_vector(1 downto 0);
			C , Z , eq: out std_logic);
end component;

signal C1, Z1, eq1, loopcondn1 : std_logic;
signal condition1 : std_logic_vector(1 downto 0);
signal opcode1: std_logic_vector(3 downto 0);
signal states1: std_logic_vector(4 downto 0);

begin

controllerfinal : statetransition port map(C => C1, Z => Z1, eq => eq1, loopcondn => loopcondn1, 
					clk => clock, rst => reset, opcode => opcode1, condition => condition1, states => states1);
datapathfinal : structure port map(state => states1, clk => clock, rst => reset, opcode => opcode1, 
					loopcondn => loopcondn1, condition => condition1, C => C1, Z => Z1, eq => eq1);
output_test <= '1';

end main;

	 