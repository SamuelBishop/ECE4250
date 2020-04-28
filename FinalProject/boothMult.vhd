library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity boothMult is
	port(
		-- Inputs
		M, Q, A: in std_logic_vector(3 downto 0); -- 4 bit Multiplicand
		Idx: in integer range 0 to 9;
		N: in integer range 0 to 9;
		-- Outputs
		Output: out std_logic_vector(7 downto 0); --8 bit
		Carry: in std_logic; --1 bit		
	);
end boothMult;

architecture structure of boothMult is
------------------- 00. COMPONENT DECLARATION -------------------
	component adder4
		port(
			A,B: in std_logic_vector(3 downto 0);
			Ci: in std_logic; -- Inputs
			S: out std_logic_vector(3 downto 0);
			Co: out std_logic); -- Output
		);
	end component;

	component subtractor4
		port(
			A,B: in std_logic_vector(5 downto 0);
			Bi: in std_logic; -- Inputs
			D: out std_logic_vector(5 downto 0);
			Bo: out std_logic); -- Output
		);
	end component;

	component ASR
		port(
			signal toShift     : in std_logic_vector(3 downto 0);
  			signal unsignedOut : out unsigned(3 downto 0)
		);
	end component;

	component twosComp
		port(
			A : in std_logic_vector(n+(n-1)*2 downto 0);
			Z : out std_logic_vector(n+(n-1)*2 downto 0)
		);
	end component;


	------------------- 01. SIGNAL/STATE DEFINITION -------------------
	signal state: integer range 7 to 1:= 0;
	signal adderCarry, adderCO, subtractorCarry, subtractorCO: bit;
	signal adderResult, subtractorResult, shiftResult: std_logic_vector(3 downto 0);
	
	------------------- 02. LOGIC IMPLEMENTATION -------------------
	begin
			process(state) 
				begin
					-- Start the state logic
					case state is
					
						-- State 1: q1q0 check
						when 1=> if ...q1q0 -> 10... then state <= 2;
							elsif ...q1q0 -> 01... then state <= 3;
							else state <= 4;
							endif;
					
						-- State 2: Subtraction
						when 2=> ...Perform subtraction of M from A... then state <= 4;

						-- State 3: Addition
						when 3=> ...Perform addition of M and A... then state <= 4;

						-- State 4: ASR
						when 4=> ...Perform ASR... then state <= 5;

						-- State 5: Decrement n
						when 5=> ...Decrement n... then state <= 6;

						-- State 6: Check 0
						when 6=> if ...n=0... then state <= 7;
							elsif ...n!=0... then state <= 1;
							endif;

						-- State 7: Report AQ
						when 7=> ...Report AQ... then state <= STOP;
					end case;
				end if;
			end process;

		-- Implementation of components via portmapping
		ADDER: adder4 port map (A, M, adderCarry, adderResult, adderCO);
		SUBTRACTOR: subtractor4 port map (A, M, subtractorCarry, subtractorResult, subtractorCO);
		RSHIFTADD: ASR port map (adderResult, shiftResult);
		RSHIFTSUB: ASR port map (subtractorResult, shiftResult);

end structure;