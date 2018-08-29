LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

ENTITY addr_counter IS
GENERIC ( COUNT_SIZE		: INTEGER := 8;
			 MAX_VAL			: INTEGER := 255);
PORT (
			CLK_IN			:	IN	STD_LOGIC;	
			resetN			:	IN	STD_LOGIC;
			en					: 	in  std_logic ;
			en1				: 	in  std_logic ;
			addr				: 	out std_logic_vector(COUNT_SIZE - 1 downto 0)
		);

END addr_counter;


	
architecture addr_counter_arch of 		addr_counter is

	
	constant one : std_logic_vector(COUNT_SIZE - 1 downto 0) := (0 => '1', others => '0');
	constant zeros : std_logic_vector(COUNT_SIZE - 1 downto 0) := (others => '0');
	constant maxval : std_logic_vector(COUNT_SIZE - 1 downto 0) := (others => '1');
begin

	process(CLK_IN,resetN)
		variable tmp : integer;
	begin
		if resetN = '0' then
			tmp := -1 ;
		elsif rising_edge(CLK_IN) then
			
			if en1 = '1' then		--start from 0 again
				tmp := 0 ;
			end if;
			
			if en = '1' and tmp /= -1 then
				tmp := tmp + 1;
				if tmp = MAX_VAL then
					tmp := -1;		-- disable
				end if;
			end if;
		end if;
		addr <= conv_std_logic_vector(tmp,COUNT_SIZE);
	end process;



end addr_counter_arch ;