library ieee;
use ieee.std_logic_1164.all;

entity subtractor6_tb is
end subtractor6_tb;

architecture test of subtractor6_tb is
	component subtractor6
		port(A,B: in std_logic_vector(5 downto 0);
			Bi: in std_logic; -- Inputs
			D: out std_logic_vector(5 downto 0);
			Bo: out std_logic); -- Output
	end component;

	signal Bi, Bo: std_logic;
	signal A, B, D: std_logic_vector(5 downto 0);

begin
	fs: subtractor6 port map(A => A, B => B, Bi => Bi, D => D, Bo => Bo);
	
	-- Could check every case with a VHDL loop
	process begin
		A <= "XXXXXX";
		B <= "XXXXXX";
		Bi <= 'X';
		wait for 10 ns;

		A <= "001000";
		B <= "000100";
		Bi <= '0';
		wait for 10 ns;

		A <= "110000";
		B <= "000001";
		Bi <= '1';
		wait for 10 ns;

		A <= "111111";
		B <= "011111";
		Bi <= '0';
		wait for 10 ns;

		A <= "101010";
		B <= "010101";
		Bi <= '1';
		wait for 10 ns;
	
		assert false report "Reached and of test";
		wait;

	end process; 
end test;