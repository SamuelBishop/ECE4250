library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ASR is
	port(
		toShift     : in std_logic_vector(3 downto 0);
  		unsignedOut : out unsigned(3 downto 0);
		outbit		: out std_logic
	);  
end ASR;

architecture behavior of ASR is
begin
    -- Right Shift
	outbit <= toShift(0);
	unsignedOut <= shift_right(unsigned(toShift), 1);
end behavior;