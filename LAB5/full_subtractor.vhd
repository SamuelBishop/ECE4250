library IEEE;
use IEEE.std_logic_1164.all;

entity full_subtractor is
		port(X,Y,Bin: in std_logic; -- Inputs
			Bout, D: Out std_logic);
end full_subtractor;

Architecture behave of full_subtractor is
begin
	Bout <= ((not X) and Bin) or ((not X) and Y) or (Y and Bin);
	D <= X xor Y xor Bin;
end behave;