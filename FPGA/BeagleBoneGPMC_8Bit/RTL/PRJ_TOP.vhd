	library		ieee,std;
	use			ieee.std_logic_1164.all	;
	use			ieee.std_logic_unsigned.all;
	use			ieee.std_logic_arith.all;
	use			ieee.std_logic_misc.all;
	
--------------------------------------------------------
	
	entity	PRJ_TOP	is
		port	(
				clk_in							:	in	std_logic							;
				--RST_L						:	in	std_logic							;
				
				--	GPMC  interface
				AD							:	inout	std_logic_vector(15 downto 8)	;
				ADV_L						:	in	std_logic							;
				WE_L						:	in	std_logic							;
				RD_L						:	in	std_logic							;	--OEN
				--CS_L						:	in	std_logic							;
				
				--	LED
				LED							:	out	std_logic_vector(1 downto 0)		;
				
				--	SW
				SW_TACT						:	in	std_logic_vector(1 downto 0)		
				);
	end	PRJ_TOP;

	architecture	arcPRJ_TOP	of	PRJ_TOP	is
--	------------------------------------------------------------------	--
--	*component															--
--	------------------------------------------------------------------	--
	--	GPMC_IF
	component	GPMC_IF	is
		port	(
				CLK							:	in	std_logic							;
				RST_L						:	in	std_logic							;
				
				AD							:	inout	std_logic_vector(15 downto 8)	;
				ADV_L						:	in	std_logic							;
				WE_L						:	in	std_logic							;
				RD_L						:	in	std_logic							;	--OEN
				CS_L						:	in	std_logic							;
				
				--	system interface
				iAddr						:	out	std_logic_vector(15 downto 8)		;
				iDataRd						:	in	std_logic_vector(15 downto 8)		;
				iDataWr						:	out	std_logic_vector(15 downto 8)		;
				ipWr						:	out	std_logic							;
				ipRd						:	out	std_logic							;
				iCS							:	out	std_logic								--unused
				
				);
	end	component;
	
	component	TEST_IP	is
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
	end	component;
	
	component PLL IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
	end component;
--	------------------------------------------------------------------	--
--	*constant	kName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	
--	------------------------------------------------------------------	--
--	*signal		wName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	signal		wAddr						:	std_logic_vector(15 downto 8)			;
	signal		wDataRd						:	std_logic_vector(15 downto 8)			;
	signal		wDataWr						:	std_logic_vector(15 downto 8)			;
	signal		wpWr						:	std_logic								;
	signal		wpRd						:	std_logic								;
	signal		wCS							:	std_logic								;
	
	signal		reset_n						:	std_logic								;
	signal		syn_reset_n						:	std_logic								;
	
	signal		CLK							:	std_logic								;
--====================================================--
--[Function] Reset
--====================================================--
	begin
--====================================================--
--[Port Map] 
--====================================================--
	
	
	U_PLL : PLL
	PORT map
	(
		areset		=>	'0'		,	--	: IN STD_LOGIC  := '0';
		inclk0		=>	clk_in	,	--	: IN STD_LOGIC  := '0';
		c0				=>	CLK		,	--	: OUT STD_LOGIC ;
		locked		=>	reset_n		--	: OUT STD_LOGIC 
	);
	
	process (CLK) begin
		if(CLK'event and CLK='1') then
			syn_reset_n		<=	reset_n	;
		end if;
	end process;
	
	
	U_GPMC_IF : GPMC_IF
		port map	(
				CLK							=>	CLK								,	--	:	in	std_logic							;
				RST_L						=>	syn_reset_n							,	--	:	in	std_logic							;
				
				AD							=>	AD								,	--	:	inout	std_logic_vector(15 downto 8)	;
				ADV_L						=>	ADV_L							,	--	:	in	std_logic							;
				WE_L						=>	WE_L							,	--	:	in	std_logic							;
				RD_L						=>	RD_L							,	--	:	in	std_logic							;	--OEN
				CS_L						=>	'0'							,
				
				--	system interface        =>									,	--	
				iAddr						=>	wAddr							,	--	:	out	std_logic_vector(15 downto 0)		;
				iDataRd						=>	wDataRd							,	--	:	in	std_logic_vector(15 downto 0)		;
				iDataWr						=>	wDataWr							,	--	:	out	std_logic_vector(15 downto 0)		;
				ipWr						=>	wpWr							,	--	:	out	std_logic							;
				ipRd						=>	wpRd							,	--	:	out	std_logic							;
				iCS							=>	wCS									--	:	out	std_logic								--unused
				
				);
	
	U_TEST_IP : TEST_IP
		port map	(
				CLK							=>	CLK								,	--	:	in	std_logic							;
				RST_L						=>	syn_reset_n							,	--	:	in	std_logic							;
				
				--	system interface        =>									,	--	
				iAddr						=>	wAddr							,	--	:	in	std_logic_vector(15 downto 0)		;
				iDataRd						=>	wDataRd							,	--	:	out	std_logic_vector(15 downto 0)		;
				iDataWr						=>	wDataWr							,	--	:	in	std_logic_vector(15 downto 0)		;
				ipWr						=>	wpWr							,	--	:	in	std_logic							;
				ipRd						=>	wpRd							,	--	:	in	std_logic							;
				iCS							=>	wCS								,	--	:	in	std_logic							;	--unused
				
				--	LED                     =>									,	--	
				LED							=>	LED								,	--	:	out	std_logic_vector(1 downto 0)		;
				
				--	SW                      =>									,	--	
				SW							=>	SW_TACT									--	:	in	std_logic_vector(1 downto 0)		
				);
	
	
	
	end	arcPRJ_TOP;
