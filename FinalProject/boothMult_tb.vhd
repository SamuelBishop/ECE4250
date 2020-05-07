library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity boothMult_tb is
end boothMult_tb;

architecture test of boothMult_tb is
	component boothMult
		port(
			M, Q, A: inout std_logic_vector(3 downto 0);
			N: inout unsigned(3 downto 0);
			Output: out std_logic_vector(7 downto 0)
		);
	end component;

-- Declaring test bench cases for the 6 bit subtractor
constant num_test_cases: integer := 5; -- Test cases
type bit_vector_array is array(1 to num_test_cases) of std_logic_vector(3 downto 0);
type output_vector_array is array(1 to num_test_cases) of std_logic_vector(7 downto 0);

constant M_value_array: bit_vector_array := ("0000", "0001", "0101", "1001", "0010"); -- 0, 1, 5, -7, 2
constant Q_value_array: bit_vector_array := ("0000", "0101", "0101", "0011", "0111"); -- 0, 5, 5,  3, 7
constant A_value_array: std_logic_vector(3 downto 0) := "0000";
constant N: unsigned(3 downto 0) := "0100";
constant Output_value_array: output_vector_array := ("00000000", "00000101", "00011001", "00010101", "00001110"); -- 0, 5, 25, -21, 14

signal M_val, Q_val, A_val: std_logic_vector(3 downto 0);
signal N_val: unsigned(3 downto 0);
signal Output_val: std_logic_vector(7 downto 0);

begin
	process begin
		for i in 1 to num_test_cases loop
			-- inputting the test cases
			M_val <= M_value_array(i);
			Q_val <= Q_value_array(i);
			A_val <= A_value_array;
			N_val <= N;
			wait for 100 ns;
			report "Test Case: " & integer'image(i); 
			assert (Output_val = Output_value_array(i))
				report "Wrong answer when multiplying Iteration #" & integer'image(i) severity error;
		end loop;
		report "Test Finished";
	end process;
	bm: boothMult port map(M_val, Q_val, A_val, N_val, Output_val);
end test;
