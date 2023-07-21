library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity statetransition is 
	port(
		C, Z, eq, loopcondn, clk, rst : in std_logic;
		opcode : in std_logic_vector(3 downto 0);
		condition : in std_logic_vector(1 downto 0);
		
		states : out std_logic_vector(4 downto 0)
	);
end entity;

architecture fsm of statetransition is

	type state is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22);
	signal spres, snext : state := s1; 
	begin

	clock : process(clk, rst)
	begin	
		if(clk='0' and clk' event) then
			if(rst='1') then
				spres <= s1; 
			else 
				spres <= snext;
			end if;
		end if;
	end process;
	
	transition : process(rst, opcode, spres, C, Z, eq, loopcondn, condition)
	begin
		if(rst = '0') then
		case spres is
			when s0 =>
				states <= "00000";
				snext <= s0;
			when s1 =>  
				states <= "00001";
				snext <= s21;  --s21 is dummy state
			when s2 => 
				states <= "00010";
				if(opcode = "0000" or opcode = "0010") then
					if(condition = "00") then snext <= s3;
					elsif(condition = "10" and C = '1') then 
						snext <= s3;
					elsif(condition = "01" and Z = '1') then 
						snext <= s3;
					else snext <= s5;
					end if;
				elsif(opcode = "1100") then
					snext <= s22; --s22 is dummy state
				elsif(opcode = "0101") then 
					snext <= s13;
				end if;	
			when s3 =>
				states <= "00011";
				if(opcode = "0000" or opcode = "0010") then 
				snext <= s4;
				elsif(opcode = "0001") then
				snext <= s7;
				elsif(opcode = "0100") then
				snext <= s11;
				elsif(opcode = "0101") then
				snext <= s2;
				end if;
			when s4 =>
				states <= "00100";
				snext <= s5;
			when s5 =>
				states <= "00101";
				snext <= s1;
			when s6 => 
				states <= "00110";
				snext <= s3;
			when s7 =>
				states <= "00111";
				snext <= s5;	
			when s8 =>
				states <= "01000";
				snext <= s5;
			when s9 =>
				states <= "01001";
				snext <= s5;
			when s10 =>
				states <= "01010";
			   snext <= s3;
			when s11 =>
				states <= "01011";
				snext <= s12;
			when s12 =>
				states <= "01100";
				snext <= s5;
			when s13 =>
				states <= "01101";
				snext <= s5;	
			when s14 => 
				states <= "01110";
				if(opcode = "0110") then
				snext <= s15;
				elsif(opcode = "0111") then
				snext <= s20;
				end if;
			when s15 =>
				states <= "01111";
				snext <= s22;
			when s16 =>
				states <= "10000";
				snext <= s17;
			when s17 =>
				states <= "10001";
				if(opcode = "0110") then
				snext <= s15;
				elsif(opcode = "0111") then
				snext <= s20;
				end if;	
			when s18 =>
				states <= "10010";
				snext <= s5;
			when s19 =>
				states <= "10011";
				snext <= s5;
			when s20 =>
				states <= "10100";
				snext <= s22;
			when s21 =>
				states <= "10101";
				if(opcode = "0000" or opcode = "0010" or opcode = "1100") then
					snext <= s2;
				elsif(opcode = "0001") then
					snext <= s6;
				elsif(opcode = "0011") then
					snext <= s8;
				elsif(opcode = "1001") then
					snext <= s9;
				elsif(opcode = "0100" or opcode = "0101") then
					snext <= s10;
				elsif(opcode = "0110" or opcode = "0111") then
					snext <= s14;
				elsif(opcode = "1000") then
					snext <= s19;	
				else snext <= s0;
				end if;
			when s22 =>
				states <= "10110";
				if(opcode = "0110" or opcode = "0111") then
				if(loopcondn = '0') then
				snext <= s5;
				else 
				snext <= s16;
				end if;
				else
				if(eq = '1') then snext <= s18;
				else snext <= s5;
				end if;
				end if;
		end case;
		end if;
	end process;
end fsm;