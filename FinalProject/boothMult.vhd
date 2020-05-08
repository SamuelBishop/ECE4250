library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity boothMult is
	port(
		-- Inputs
		M, Q, A: inout std_logic_vector(3 downto 0); -- 4 bit Multiplicand
		N: inout integer;
		-- Outputs
		Output: out std_logic_vector(7 downto 0) --8 bit
	);
end boothMult;

architecture structure of boothMult is
------------------- 00. COMPONENT DECLARATION -------------------
	component adder4
		port(
			A,B: in std_logic_vector(3 downto 0);
			Ci: in std_logic; -- Inputs
			S: out std_logic_vector(3 downto 0);
			Co: out std_logic -- Output
		);
	end component;

	component subtractor4
		port(
			A,B: in std_logic_vector(3 downto 0);
			Bi: in std_logic; -- Inputs
			D: out std_logic_vector(3 downto 0);
			Bo: out std_logic -- Output
		);
	end component;

	component ASR
		port(
			toShift     : in std_logic_vector(3 downto 0);
  			unsignedOut : out unsigned(3 downto 0);
			outbit		: out std_logic
		);
	end component;

	------------------- 01. CONSTATNT/SIGNAL/STATE DEFINITION -------------------
	constant N_val: integer := N;
	signal state: integer := 0;
	signal Q0, subtractorCarry, subtractorCO, adderCarry, adderCO: std_logic := '0';

	------------------- 02. LOGIC PROCESSING -------------------
	begin

	-- "NOT" a state machine but very very similar to a state machine
	GEN_ADD: for i in 0 to N_val generate
		if (state = 0) then
			if (Q(0) = '1' and Q0 = '0') then
				state <= 1;
			elsif (Q(0) = '0' and Q0 = '1') then
				state <= 2;
			else
				state <= 3;
			end if;
		
		elsif (state = 1)
			SUB: generate 
				SUBTRACTOR: subtractor4 port map (A, M, subtractorCarry, A, subtractorCO);
			end generate SUB;
			state <= 3;

		elsif (state = 2)
			ADD: generate
				ADDER: adder4 port map (A, M, adderCarry, M, adderCO);
			end generate ADD;
			state <= 3;

		elsif (state = 3)
			SA: generate 
				RSHIFTA: ASR port map (A, A, shiftCarry1);
			end generate SA;
			SQ: generate
				RSHIFTQ: ASR port map (Q, Q, shiftCarry2);
			end generate SQ;
			Q(3) <= shiftCarry1;
			Q0 <= shiftCarry2;
			state <= 0;
		
		end if;
	end loop;

	OP(7) <= A(3); 
	OP(6) <= A(2); 
	OP(5) <= A(1); 
	OP(4) <= A(0);
	OP(3) <= Q(3); 
	OP(2) <= Q(2); 
	OP(1) <= Q(1); 
	OP(0) <= Q(0);			

end structure;