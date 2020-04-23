library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.numeric_std.all ;
entity GenClock is
generic (time_period : integer range 1 to 4 );
port (clk : in std_logic ;
Clock : inout std_logic );
End GenClock ;
Architecture Behavior of GenClock is
begin
process (clk)
variable counter : integer range 1 to 200000000 ;
begin
if (clk' event and clk = '1' ) then
counter := counter +1 ;
if (time_period = 1 AND counter = 25000000 ) then
Clock <= not Clock;
counter :=1 ;
elsif (time_period = 2 AND counter = 50000000 ) then
Clock <= not Clock;
counter :=1 ;
elsif (time_period = 3 AND counter = 100000000 ) then
Clock <= not Clock;
counter :=1 ;
elsif (time_period = 4 AND counter = 200000000 ) then
Clock <= not Clock;
counter :=1 ;
end if ;
end if ;
end process ;
end Behavior ;
