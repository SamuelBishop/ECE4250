library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdder is
		port(X,Y,Cin: in std_logic; -- Inputs
			Cout, Sum: Out std_logic);
end FullAdder;

Architecture behave of FullAdder is
begin
	Cout <= (X and Y) or (X and Cin) or (Y and Cin) after 10 ns;
	Sum <= X xor Y xor Cin after 10 ns;
end behave;
