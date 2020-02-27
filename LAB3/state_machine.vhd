library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity state_machine is
		port(
			X,Y, CLK: in std_logic; -- Inputs
			Z: Out std_logic
		);
end state_machine;

Architecture behave of state_machine is
------------------- 00. STATE DEFINITIONS -------------------
	type stateval is (s0, s1, s2, s3);
	signal state, next_state: stateval;



begin	-- beggining the behavioral portion or architecture
------------------- 01. STATE REGISTER -------------------
	process(CLK) -- setting up the clock
		begin
			if(CLK'event and CLK='1') then
				state <= next_state; -- do the clock stuff here
			end if;
	end process;



------------------- 02. STATE LOGIC -------------------
process (state,X,Y)
   begin
      case state is
		-- directions for the 0 state
		when s0 => if(X="0" and Y="0") then next_state <= s0; 
        when s0 => if(X="0" and Y="1") then next_state <= s1;
		when s0 => if(X="1" and Y="0") then next_state <= s2;
		when s0 => if(X="1" and Y="1") then next_state <= s1;

		-- directions for the 1st state
		when s1 => if(X="0") and (Y="0") then next_state <= s1; 
        when s1 => if(X="0") and (Y="1") then next_state <= s0;
		when s1 => if(X="1") and (Y="0") then next_state <= s2;
		when s1 => if(X="1") and (Y="1") then next_state <= s3;

		-- directions for the 2nd state
		when s2 => if(X="0") and (Y="0") then next_state <= s2; 
        when s2 => if(X="0") and (Y="1") then next_state <= s3;
		when s2 => if(X="1") and (Y="0") then next_state <= s3;
		when s2 => if(X="1") and (Y="1") then next_state <= s1;

		-- directions for the 3rd state
		when s3 => if(X="0") and (Y="0") then next_state <= s3; 
        when s3 => if(X="0") and (Y="1") then next_state <= s0;
		when s3 => if(X="1") and (Y="0") then next_state <= s1;
		when s3 => if(X="1") and (Y="1") then next_state <= s0;
			
		end case;
end process;



------------------- 03. OUTPUT LOGIC -------------------
Z <= '1' when (state = s2) or (state = s3) else '0';

end behave;
