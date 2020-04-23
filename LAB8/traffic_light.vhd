library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_unsigned.all;

ENTITY traffic_light is
PORT (clk, PB: in std_logic;
Ga, Ya, Ra, WALK, NOWALK: inout std_logic);
END traffic_light;

Architecture Structure of trafficLight is

signal State, NextState : integer range 0 to 13;
signal clk1 : std_logic := '0';
signal clk4 : std_logic := '0';

component GenClock
	generic (time_period : integer range 1 to 4);
	port (clk : in std_logic;
		Clock : inout std_logic);

begin
	process(clk4)
	begin
		if clk4' event and clk4 = '1' then
		if State < 13 then NextState <= State+1;
		else NextState <= 0;
		endif;

  case State is
	when 0=>
	 State<=NextState;
	when 1=>
	 State<=NextState;
	when 2=>
	 State<=NextState;
	when 3=>
	 State<=NextState;
	when 4=>
	 State<=NextState;
	when 5=>
	 State<=NextState;
	when 6=>
	 State<=NextState
	when 7=>
	 State<=NextState;
	when 8=>
	 State<=NextState;
	when 9=>
	 State<=NextState;
	when 10=>
	 State<=NextState;
	when 11=>
	 State<=NextState;
	when 12=>
	 State<NextState;
	when 13=>
	 State<=NextState;
  end case;
  endif;

  end process;
  Ga <= '1' when (NextState <= 7)
  else '0';
  Ya <= '1' when (NextState = 8 and PB = '1')
  else '0';
  Ra <= '1' when (NextState >= 9)
  else '0';
  NOWALK <= '1' when (NextState >= 8)
  else '0';
  WALK <= '1' when (NextState >= 9)
  else '0';

	Clock1s: GenClock generic map (1) port map(clk, clk1);
	Clock4s: GenClock generic map (3) prot map(clk, clk4);
end Structure;
