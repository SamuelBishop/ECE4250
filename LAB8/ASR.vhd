library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ASR is
	port(
		signal r_Shift1     : in std_logic_vector(3 downto 0) := "1000";
  		signal r_Unsigned_R : out unsigned(3 downto 0)        := "0000";
  		signal r_Signed_R   : out signed(3 downto 0)          := "0000"
	);  
end ASR;

architecture behavior of ASR is
begin
    -- Right Shift
	r_Unsigned_R <= shift_right(unsigned(r_Shift1), 2);
	r_Signed_R   <= shift_right(signed(r_Shift1), 	2);
end behavior;