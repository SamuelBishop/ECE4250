library IEEE;
use IEEE.std_logic_1164.all;

entity Adder4 is
	port(A,B: in std_logic_vector(3 downto 0);
		Ci: in std_logic; -- Inputs
		S: out std_logic_vector(3 downto 0);
		Co: out std_logic); -- Output
	end Adder4;

Architecture Structure of Adder4 is

	component FullAdder
		port(X,Y,Cin: in std_logic; -- Inputs
			Cout, Sum: Out std_logic); -- Outputs
		end component;

	signal C: std_logic_vector(3 downto 1);
	begin
	FA1: FullAdder port map (A(0), B(0), Ci, C(1), S(0));
	FA2: FullAdder port map (A(1), B(1), Ci, C(2), S(1));
	FA3: FullAdder port map (A(2), B(2), Ci, C(3), S(2));
	FA4: FullAdder port map (A(3), B(3), C(3), Co, S(3));
	end Structure;
