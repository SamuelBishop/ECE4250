library IEEE;
use IEEE.numeric_bit.all;

entity cascaded_bcd_counter is
	port(
		LD, CL, P, T, CLOCK: in bit;
		Din1, Din2: in unsigned(3 downto 0);
		Count: out integer range 0 to 99;
		Carry2: out bit
	);
end cascaded_bcd_counter;

Architecture structure of cascaded_bcd_counter is

	component fully_synchronous_counter
		port(
			LOAD, CLR, UP, ENABLE, CLK: in bit;
			D: in unsigned(3 downto 0);
			Cout: out bit;
			Qout: out unsigned(3 downto 0)
		);
	end component;

	signal Carry1: bit;
	signal Qout1, Qout2: unsigned(3 downto 0);
	
	begin
	COUNT1: fully_synchronous_counter port map (LD, CL, P, T, CLOCK, Din1, Carry1, Qout1);
	COUNT2: fully_synchronous_counter port map (LD, CL, P, Carry1, CLOCK, Din2, Carry2, Qout2);
	Count <= to_integer(Qout2 & Qout1);

end structure;
