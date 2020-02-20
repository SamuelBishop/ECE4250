library IEEE;
use IEEE.std_logic_1164.all;

entity fullSubtractor is
		port(X,Y,Bin: in std_logic; -- Inputs
			Bout, D: Out std_logic);
end fullSubtractor;

Architecture behave of fullSubtractor is
begin
	Bout <= ((not X) and Bin) or ((not X) and Y) or (X and Bin) after 10 ns;
	D <= (X xor Y) xor Bin after 10 ns;
end behave;