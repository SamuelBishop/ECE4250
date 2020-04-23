library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ASR is
	port(
		signal toShift     : in std_logic_vector(3 downto 0);
  		signal unsignedOut : out unsigned(3 downto 0);
  		signal signedOut   : out signed(3 downto 0)
	);  
end ASR;

architecture behavior of ASR is
begin
    -- Right Shift
	unsignedOut <= shift_right(unsigned(toShift), 1);
	signedOut   <= shift_right(signed(toShift),   1);
end behavior;