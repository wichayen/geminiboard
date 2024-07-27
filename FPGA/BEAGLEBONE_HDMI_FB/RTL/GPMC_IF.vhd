	library		ieee,std;
	use			ieee.std_logic_1164.all	;
	use			ieee.std_logic_unsigned.all;
	use			ieee.std_logic_arith.all;
	use			ieee.std_logic_misc.all;



use			work.General_PKG.all;

--------------------------------------------------------
	-- address
	-- 0x0000 -> frame buffer pixel address
	-- 0x8000 -> frame buffer data (auto increment)
	--
	--
	
	entity	GPMC_IF	is
		port	(
				CLK							:	in	std_logic							;
				RST_L						:	in	std_logic							;
				
				AD							:	inout	std_logic_vector(15 downto 0)	;
				ADV_L						:	in	std_logic							;
				WE_L						:	in	std_logic							;
				RD_L						:	in	std_logic							;	--OEN
				CS_L						:	in	std_logic							;
				
				--	system interface
				iAddr						:	out	std_logic_vector(15 downto 0)		;
				iDataRd						:	in	std_logic_vector(15 downto 0)		;
				iDataWr						:	out	std_logic_vector(15 downto 0)		;
				ipWr						:	out	std_logic							;
				ipRd						:	out	std_logic							;
				iCS							:	out	std_logic								--unused
				
				);
	end	GPMC_IF;

	architecture	arcGPMC_IF	of	GPMC_IF	is
--	------------------------------------------------------------------	--
--	*component															--
--	------------------------------------------------------------------	--
	
--	------------------------------------------------------------------	--
--	*constant	kName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	
--	------------------------------------------------------------------	--
--	*signal		wName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	signal		wAD							:	std_logic_vector(15 downto 0)		;
	signal		wAddr						:	std_logic_vector(15 downto 0)		;
	signal		wADV_L					:	std_logic							;
	signal		wWE_L						:	std_logic							;
	signal		wOE_L						:	std_logic							;
	signal		wCS_L						:	std_logic							;
	
	signal		wADV_L_DL1					:	std_logic							;
	signal		wOE_L_DL1					:	std_logic							;
	signal		wWE_L_DL1					:	std_logic							;
	
	signal		wpWE						:	std_logic							;
	signal		wpRD						:	std_logic							;
	
	signal		wGate						:	std_logic							;
	
	signal		wDataRd						:	std_logic_vector(15 downto 0)		;
--====================================================--

--====================================================--
	
	
	begin
--====================================================--
--[Port Map] 
--====================================================--
	
	--	synchronize
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wAD		<=	(others => '0')	;
			wADV_L	<=	'1'					;
			wWE_L	<=	'1'					;
			wOE_L	<=	'1'					;
			wCS_L	<=	'1'					;
		elsif ( CLK'event and CLK = '1' ) then
			wAD		<=	AD					;
			wADV_L	<=	ADV_L				;
			wWE_L	<=	WE_L				;
			wOE_L	<=	RD_L				;
			wCS_L	<=	CS_L				;
		end if;
	end process;
	
	--	signal delay
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wADV_L_DL1	<=	'1'	;
			wOE_L_DL1	<=	'1'	;
			wWE_L_DL1	<=	'1'	;
		elsif ( CLK'event and CLK = '1' ) then
			wADV_L_DL1	<=	wADV_L	;
			wOE_L_DL1	<=	wOE_L	;
			wWE_L_DL1	<=	wWE_L	;
		end if;
	end process;
	
	--	-->>	GPMC to LBUS	------------------------
	
	--	DATA inout control
	wGATE	<= 	'1'		when(wOE_L = '0'and wWE_L = '1')	else
				'0';
	--AD		<=	wDataRd		when(wGate = '1')	else	(others => 'Z')	;	--??? for test
	AD		<=	(others => 'Z')	;
	
	--	address sampling
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wAddr		<=	(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			--if(fFallEdge(wADV_L, wADV_L_DL1) and wCS_L = '0')then
			if(fFallEdge(wADV_L, wADV_L_DL1))then
				wAddr	<=	wAD	;
			end if;
		end if;
	end process;
	--iAddr	<=	wAddr & x"00"	;
	iAddr	<=	wAddr	;
	
	--	read cycle
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wpRD		<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(fFallEdge(wOE_L, wOE_L_DL1) and wCS_L = '0')then
				if(wWE_L = '1')then
					wpRD	<=	'1'	;
				end if;
			else
				wpRD	<=	'0'	;
			end if;
		end if;
	end process;
	ipRd	<=	wpRD	;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wDataRd	<=	(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			wDataRd	<=	iDataRd		;
		end if;
	end process;
	
	--	write cycle
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			iDataWr		<=	(others => '0')	;
			wpWE		<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(fFallEdge(wWE_L, wWE_L_DL1) and wCS_L = '0')then
				if(wOE_L = '1')then
					iDataWr	<=	wAD	;
					wpWE	<=	'1'	;
				end if;
			else
				wpWE	<=	'0'	;
			end if;
		end if;
	end process;
	ipWr	<=	wpWE	;
	
	--	<<--	GPMC to LBUS	------------------------
	
	
	
	
	end	arcGPMC_IF;
