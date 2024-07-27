	library		ieee;
	use			ieee.std_logic_1164.all	;
	use			ieee.std_logic_unsigned.all;
	use			ieee.std_logic_arith.all;
	use			ieee.std_logic_misc.all;
	
	use			std.textio.all;
	use			std.env.all;
	use			ieee.std_logic_textio.all;
	
	package	SIM_PKG	is
	
	type	tGPMC_BUS	is	
		record
			CS_L				:	std_logic						; -- 0:Chip Enable
			WE_L				:	std_logic						; -- 0:Write Enable
			RD_L				:	std_logic						; -- 0:Read  Enable
			ADV_L				:	std_logic						; -- 0:address valid  Enable
			AD					:	std_logic_vector( 15 downto 0 )	;
		end record;
	
	procedure	GPMC_Wr	(
				Addr			:	in	std_logic_vector( 31 downto 0 );
				DataIn			:	in	std_logic_vector( 15 downto 0 );
		signal	BUSCLK			:	in	std_logic							;
		signal	iCPUBUS			:	inout	tGPMC_BUS							;
				DelayCycle		:	in	integer								
		);
		
	procedure	GPMC_Rd	(
				Addr			:	in	std_logic_vector( 31 downto 0 )	;
		signal	DataOut			:	out	std_logic_vector( 15 downto 0 )	;
		signal	BUSCLK			:	in	std_logic							;
		signal	iCPUBUS			:	inout	tGPMC_BUS							;
				DelayCycle		:	in	integer								
		);
	
	end	SIM_PKG;
	
--------------------------------------------------------
	package	body SIM_PKG	is
--------------------------------------------------------

--------------------------------------------------------

--------------------------------------------------------
	procedure	GPMC_Wr	(
				Addr			:	in	std_logic_vector( 31 downto 0 );
				DataIn			:	in	std_logic_vector( 15 downto 0 );
		signal	BUSCLK			:	in	std_logic							;
		signal	iCPUBUS			:	inout	tGPMC_BUS							;
				DelayCycle		:	in	integer								
		)	is
		
		variable	vDelayCycle	:	integer								;
	begin
		vDelayCycle			:=	0	;
		iCPUBUS.AD		<=	(others => 'Z')	;
		iCPUBUS.CS_L	<=	'1'					;
		iCPUBUS.WE_L	<=	'1'					;
		iCPUBUS.RD_L	<=	'1'					;
		iCPUBUS.ADV_L	<=	'1'					;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.CS_L	<=	'0'					;
		iCPUBUS.AD		<=	Addr(15 downto 0)	;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.ADV_L	<=	'0'					;
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.ADV_L	<=	'1'					;
		iCPUBUS.AD		<=	DataIn				;
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.WE_L	<=	'0'					;
		wait until BUSCLK'event and BUSCLK = '1';
		while(vDelayCycle <= DelayCycle) loop
			wait until BUSCLK'event and BUSCLK = '1';
			vDelayCycle	:=	vDelayCycle + 1;
		end loop;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.WE_L	<=	'1'				;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.AD		<=	(others => 'Z')	;
		iCPUBUS.CS_L	<=	'1'					;
		iCPUBUS.WE_L	<=	'1'					;
		iCPUBUS.RD_L	<=	'1'					;
		iCPUBUS.ADV_L	<=	'1'					;
	end GPMC_Wr	;
	
	
	procedure	GPMC_Rd	(
				Addr			:	in	std_logic_vector( 31 downto 0 )	;
		signal	DataOut			:	out	std_logic_vector( 15 downto 0 )	;
		signal	BUSCLK			:	in	std_logic							;
		signal	iCPUBUS			:	inout	tGPMC_BUS							;
				DelayCycle		:	in	integer								
		)	is
		
		variable	vDelayCycle	:	integer								;
	begin
		vDelayCycle			:=	0	;
		iCPUBUS.AD		<=	(others => 'Z')	;
		iCPUBUS.CS_L	<=	'1'					;
		iCPUBUS.WE_L	<=	'1'					;
		iCPUBUS.RD_L	<=	'1'					;
		iCPUBUS.ADV_L	<=	'1'					;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.CS_L	<=	'0'					;
		iCPUBUS.AD		<=	Addr(15 downto 0)	;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.ADV_L	<=	'0'					;
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.ADV_L	<=	'1'					;
		iCPUBUS.AD		<=	(others => 'Z')	;
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.RD_L	<=	'0'					;
		while(vDelayCycle <= DelayCycle) loop
			wait until BUSCLK'event and BUSCLK = '1';
			vDelayCycle	:=	vDelayCycle + 1;
		end loop;
		wait until BUSCLK'event and BUSCLK = '1';
		DataOut				<=	iCPUBUS.AD		;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.RD_L	<=	'1'				;
		wait until BUSCLK'event and BUSCLK = '1';
		iCPUBUS.AD		<=	(others => 'Z')	;
		iCPUBUS.CS_L	<=	'1'					;
		iCPUBUS.RD_L	<=	'1'					;
		iCPUBUS.RD_L	<=	'1'					;
		iCPUBUS.ADV_L	<=	'1'					;
	end GPMC_Rd	;
	
	
	end	SIM_PKG;
