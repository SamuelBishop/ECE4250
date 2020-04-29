library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity boothMult is
	port(
		-- Inputs
		M, Q, A: in std_logic_vector(3 downto 0); -- 4 bit Multiplicand
		Idx: in integer range 0 to 9;
		N: inout integer range 0 to 9;
		-- Outputs
		Output: out std_logic_vector(7 downto 0); --8 bit
		Carry: in std_logic --1 bit		
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

	component twosComp
		port(
			A : in std_logic_vector(n+(n-1)*2 downto 0);
			Z : out std_logic_vector(n+(n-1)*2 downto 0)
		);
	end component;


	------------------- 01. SIGNAL/STATE DEFINITION -------------------
	signal state: integer range 0 to 6:= 0;
	signal Q0, adderCarry, adderCO, shiftCarry, subtractorCarry, subtractorCO: std_logic := '0';
	signal shiftResult: unsigned(3 downto 0);
	signal AddSubResult: std_logic_vector(3 downto 0);
	signal ending: std_logic := '0';

	-- Implementation of components via portmapping
	begin
	ADDER: adder4 port map (A, M, adderCarry, AddSubResult, adderCO);
	SUBTRACTOR: subtractor4 port map (A, M, subtractorCarry, AddSubResult, subtractorCO);
	RSHIFT: ASR port map (AddSubResult, shiftResult, shiftCarry);

	------------------- 02. LOGIC IMPLEMENTATION -------------------
			process(state) 
			begin
				-- Start the state logic
					case state is
					
						-- State 1: q1q0 check
						when 0 => if Q(0) = '1' and Q0 = '1' then state <= 1;
							elsif Q(0) = '0' and Q0 = '1'then state <= 2;
							else state <= 3;
							end if;
					
						-- State 2: Subtraction
						when 1 => state <= 3;

						-- State 3: Addition
						when 2 => state <= 3;

						-- State 4: ASR
						when 3 => state <= 4;

						-- State 5: Decrement n
						when 4 => state <= 5;

						-- State 6: Check 0
						when 5 => if N = 0 then state <= 6;
							else state <= 1; 
							end if;

						-- State 7: Report AQ
						when 6 => ending <= '1';
					end case;
			end process;

	-- Do all conditional statements here
	-- 2) AddSubResult => (A - M);
	AddSubResult <= A when (state = 2);
	-- 3) AddSubResult => (A + M);
	AddSubResult <= A when (state = 3);
	-- 5) N => N-1;
	N <= N - 1 when (state = 5);

end structure;