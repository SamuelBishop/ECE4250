library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity twosComp is
	generic(n : integer := 8);
	port (
		A : in std_logic_vector(n+(n-1)*2 downto 0);
		Z : out std_logic_vector(n+(n-1)*2 downto 0)
	);
end entity twosComp;

architecture behave of twosComp is
	signal atTwoCompl : std_logic_vector(n+(n-1)*2 downto 0);

	begin
	process(A, atTwoCompl)
		begin
			AtwoCompl <= not(A) + '1';
			Z <= atTwoCompl;
	end process;

end architecture behave;
