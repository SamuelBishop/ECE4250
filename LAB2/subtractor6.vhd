library IEEE;
use IEEE.std_logic_1164.all;

entity subtractor6 is
	port(A,B: in std_logic_vector(5 downto 0);
		Bi: in std_logic; -- Inputs
		D: out std_logic_vector(5 downto 0);
		Bo: out std_logic); -- Output
	end subtractor6;

Architecture Structure of subtractor6 is

	component fullSubtractor
		port(X,Y,Bin: in std_logic; -- Inputs
			Bout, D: Out std_logic); -- Outputs
		end component;

	signal C: std_logic_vector(5 downto 1);
	begin
	FS1: fullSubtractor port map (A(0), B(0), Bi, C(1), D(0));
	FS2: fullSubtractor port map (A(1), B(1), C(1), C(2), D(1));
	FS3: fullSubtractor port map (A(2), B(2), C(2), C(3), D(2));
	FS4: fullSubtractor port map (A(3), B(3), C(3), C(4), D(3));
	FS5: fullSubtractor port map (A(4), B(4), C(4), C(5), D(4));
	FS6: fullSubtractor port map (A(5), B(5), C(5), Bo, D(5));
	end Structure;
