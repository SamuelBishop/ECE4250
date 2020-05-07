library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity boothMult is
	port(
		-- Inputs
		M, Q, A: inout std_logic_vector(3 downto 0); -- 4 bit Multiplicand
		N: inout unsigned(3 downto 0);
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

	------------------- 01. SIGNAL/STATE DEFINITION -------------------
	signal state: integer range 0 to 6:= 0;
	signal Q0, adderCarry, adderCO, shiftCarry1, shiftCarry2, subtractorCarry, subtractorCO: std_logic := '0';
	signal shiftResultA, shiftResultQ: unsigned(3 downto 0);
	signal Nsig: unsigned(3 downto 0) := "0100";
	signal Accumulator, Multiplier, Multiplicand, AddSubOutput: std_logic_vector(3 downto 0);
	signal OP: std_logic_vector(7 downto 0);

	-- Implementation of components via portmapping
	begin

	------------------- 02. LOGIC IMPLEMENTATION -------------------
			process(state) 
			begin
				-- Start the state logic
					case state is
					
						-- State 0: q1q0 check
						when 0 => if Q(0) = '1' and Q0 = '0' then state <= 1;
							elsif Q(0) = '0' and Q0 = '1'then state <= 2;
							else state <= 3;
							end if;
					
						-- State 1: Subtraction
						when 1 => 
							Accumulator <= A;
							Multiplicand <= M;
							state <= 3;

						-- State 2: Addition
						when 2 =>
							Accumulator <= A;
							Multiplicand <= M;
							state <= 3;

						-- State 3: ASR
						when 3 => 
							Accumulator <= std_logic_vector(shiftResultA); -- Perform shift on A
							Multiplier(0) <= shiftCarry1; -- Set the outbit to the first element of Q
							Multiplier <= std_logic_vector(shiftResultQ); -- Perform shift on Q
							Q0 <= shiftCarry2; -- Set the outbit to the Q0 element
							A <= Accumulator;
							M <= Multiplicand;
							state <= 4;

						-- State 4: Decrement n
						when 4 => 
							Nsig <= Nsig - 1;
							state <= 5;

						-- State 5: Check 0
						when 5 => if Nsig = 0 then state <= 6;
							else state <= 0; 
							end if;

						-- State 6: Report AQ
						when 6 => OP(7) <= Accumulator(3); OP(6) <= Accumulator(2); OP(5) <= Accumulator(1); OP(4) <= Accumulator(0);
							OP(3) <= Multiplier(3); OP(2) <= Multiplier(2); OP(1) <= Multiplier(1); OP(0) <= Multiplier(0);
					end case;
			end process;

	-- Do all conditional statements here
	-- 1) AddSubResult => (A - M);
	SUBTRACTOR: subtractor4 port map (Accumulator, Multiplicand, subtractorCarry, AddSubOutput, subtractorCO);
	-- 2) AddSubResult => (A + M);
	ADDER: adder4 port map (Accumulator, Multiplicand, adderCarry, AddSubOutput, adderCO);
	-- 3) Perform ASR on A;
	RSHIFTA: ASR port map (Accumulator, shiftResultA, shiftCarry1);
	RSHIFTQ: ASR port map (Accumulator, shiftResultQ, shiftCarry2);

	-- 6) Output = OP
	Output <= OP when (state = 6);

end structure;
