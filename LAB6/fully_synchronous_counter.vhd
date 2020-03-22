library IEEE;
use IEEE.numeric_bit.all;

entity fully_synchronous_counter is
	port(
		LOAD, CLR, UP, ENABLE, CLK: in bit;
		D: in unsigned(3 downto 0);
		Cout: out bit;
		Qout: out unsigned(3 downto 0)
	);
end fully_synchronous_counter;

architecture behave of fully_synchronous_counter is

	signal Q: unsigned(3 downto 0);  -- counter register

begin
	Qout <= Q;

	process(CLK, CLR)
	begin
		if CLR='1' then -- priority given to CLR
			Q <= "0000";
		elsif (CLK'event and CLK = '1') then -- catch rising edge
			if (LOAD and ENABLE) = '1' then
				Q <= D;
			elsif LOAD = '0' and (ENABLE and UP) = '1' then -- increment instructions
				if Q = "1001" then
					Cout <= '1';
					Q <= "0000";
				else
					Q <= Q + 1;
				end if;
			elsif (LOAD and UP) = '0' and ENABLE = '1' then -- decrement instructions
				if Q = "0000" then
					Cout <= '1';
					Q <= "1001";
				else
					Q <= Q - 1;
				end if;
			end if;
		end if;
	end process;

end behave;
