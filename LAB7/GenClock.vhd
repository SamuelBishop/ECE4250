library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity GenClock is
	-- Generic is like an enumeration of the time period type.
	Generic(time_period : integer range 1 to 4 ); -- time period variable has 4 ranges (.5s, 1s, 2s, 4s)
	Port (
		clk: in std_logic;
 		Clock: out std_logic
	);
End GenClock;

Architecture Behavior of GenClock is
signal clock_value: std_logic;
begin
	Clock <= clock_value;
 	process (clk)
	begin
		if time_period = 1 then
 			clock_value <= '1' after 500 ms;
		elsif time_period = 2 then
			clock_value <= '1' after 1000 ms;
		elsif time_period = 3 then
			clock_value <= '1' after 2000 ms;
		elsif time_period = 4 then
			clock_value <= '1' after 4000 ms;
		end if;
	end process;
 end Behavior;
