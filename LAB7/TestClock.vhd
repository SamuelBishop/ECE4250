library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity TestClock is
	Port ( 
		in1, in2, in3, in4: in std_logic;
		out1, out2, out3, out4: out std_logic
	);
end TestClock;

Architecture Execute of TestClock is
	Component GenClock
		Generic(time_period : integer range 1 to 4 );
		Port (
			clk: in std_logic;
 			Clock: out std_logic
		);
	end Component;

	-- Declaring test bench cases for GenClock
	begin
 		GC1: GenClock generic map (1) port map (in1, out1);
		GC2: GenClock generic map (2) port map (in2, out2);
		GC3: GenClock generic map (3) port map (in3, out3);
		GC4: GenClock generic map (4) port map (in4, out4);
end execute; 
