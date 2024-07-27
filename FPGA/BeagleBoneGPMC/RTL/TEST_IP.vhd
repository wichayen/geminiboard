	library		ieee,std;
	use			ieee.std_logic_1164.all	;
	use			ieee.std_logic_unsigned.all;
	use			ieee.std_logic_arith.all;
	use			ieee.std_logic_misc.all;

--------------------------------------------------------
	
	entity	TEST_IP	is
		port	(
				CLK							:	in	std_logic							;
				RST_L						:	in	std_logic							;
				
				--	system interface
				iAddr						:	in	std_logic_vector(15 downto 8)		;
				iDataRd						:	out	std_logic_vector(15 downto 8)		;
				iDataWr						:	in	std_logic_vector(15 downto 8)		;
				ipWr						:	in	std_logic							;
				ipRd						:	in	std_logic							;
				iCS							:	in	std_logic							;	--unused
				
				--	LED
				LED							:	out	std_logic_vector(1 downto 0)		;
				
				--	SW
				SW							:	in	std_logic_vector(1 downto 0)		
				
				);
	end	TEST_IP;

	architecture	arcTEST_IP	of	TEST_IP	is
--	------------------------------------------------------------------	--
--	*component															--
--	------------------------------------------------------------------	--
	
--	------------------------------------------------------------------	--
--	*constant	kName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	constant	kLED_ADDR					:	std_logic_vector(15 downto 8)		:=	x"00"	;
	constant	kSW_ADDR					:	std_logic_vector(15 downto 8)		:=	x"01"	;
--	------------------------------------------------------------------	--
--	*signal		wName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	signal		wLED						:	std_logic_vector(15 downto 8)		;
--====================================================--
--[Function] Reset
--====================================================--
	begin
--====================================================--
--[Port Map] 
--====================================================--
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wLED	<=	(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			if( ipWr = '1')then
				case	iAddr	is
					when	kLED_ADDR		=>
						wLED	<=	iDataWr	;
					when	others	=>	null;
				end case;
			end if;
		end if;
	end process;
	LED(0)		<=	not wLED(8)	;
	LED(1)		<=	not wLED(9)	;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			iDataRd		<=	(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			if(ipRd = '1')then
				case	iAddr	is
					when	kLED_ADDR		=>
						iDataRd		<=	wLED	;
					when	kSW_ADDR		=>
						--iDataRd		<=	SW	;
					when	others	=>	null;
				end case;
			end if;
		end if;
	end process;
	
	
	end	arcTEST_IP;
