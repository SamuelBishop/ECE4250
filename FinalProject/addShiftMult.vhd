library ieee;
use ieee.numeric_bit.all;
use ieee.std_logic_1164.all;

entity addShiftMult is
	port(
		Clk, St: in bit;
		Multiplier, Multiplicand: in unsigned(3 downto 0);
		Done: out bit);
end addShiftMult;

architecture behave of addShiftMult is
	signal State: integer range 0 to 9;
	signal ACC: unsigned(8 downto 0);
	alias M: bit is ACC(0);

	begin
		process(Clk)
		begin
			if(Clk'event and Clk = '1') then
				case State is
					when 0 =>
						if St = '1' then
							ACC(8 downto 4) <= "00000";
							ACC(3 downto 0) <= Multiplier;
							State <= 1;
						end if;
					when 1 | 3 | 5 | 7 =>
						if M = '1' then
							ACC(8 downto 4) <= '0' & ACC(7 downto 4) + Multiplicand;
							State <= State + 1;
						else
							ACC <= '0' & ACC(8 downto 1);
							State <= State + 2;
						end if;
					when 2 | 4 | 6 | 8 =>
						ACC <= '0' & ACC(8 downto 1);
						State <= State + 1;
					when 9 =>
						State <= 0;
				end case;
			end if;
		end process;
	Done <= '1' when State = 9 else '0';
end behave;