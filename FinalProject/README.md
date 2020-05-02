# Booth Multiplier Circuit (VHDL)

This is the repository for the Booth Multiplier Circuit Final Project created for ECE4250 (VHDL and Programmable Logic Devices). It contains the VHDL code for a 1-bit adder, 1-bit subtractor, 4-bit adder, 4-bit subtractor, arithmetic shift right, and uses all of these components in a structural architecture through state machine implementation to construct a Booth's Multiplier (4 bit inputs, 8 bit output).

## Functionality and Usage

Booth's multiplication algorithm is a multiplication algorithm that multiplies two signed binary numbers. Booth's multiplication algorithm is extremely helpful in the Computer Science and Electrical Engineering world because it operates based upon the fact that binary strings within the multiplier given certain conditions require no addition and instead can be shifted, greatly reducing the time complexity and cost efficiency of a multiplier.

More traditional multiplier circuits include the Add-and-Shift and the Array Multiplier Circuit which sport drastically slower worst-case and average-case multiply times.

The `boothMult.vhd` circuit is a composition of the `adder4.vhd`, `subtractor4.vhd`, and `ASR.vhd` circuits.
```VHDL
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
```
After the components are defined within the Booth Multiplier file a finite state machine handles signal and logic processing.
