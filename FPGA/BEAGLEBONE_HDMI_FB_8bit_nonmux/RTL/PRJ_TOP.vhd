----------------------------------------------------------------------
-- TITLE : DVI test (for DE0-nano)
--
--     VERFASSER : S.OSAFUNE (J-7SYSTEM Works)
--     DATUM     : 2012/09/04 -> 2012/09/04 (HERSTELLUNG)
--               : 2013/01/31 (FESTSTELLUNG)
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity PRJ_TOP is
	generic (
--		RESOLUTION		: string := "VGA"		-- 25.175MHz,640x480,60Hz,4:3
--		RESOLUTION		: string := "SVGA"		-- 40.000MHz,800x600,60Hz,4:3
--		RESOLUTION		: string := "XGA"		-- 65.000MHz,1024x768,60Hz,4:3
		RESOLUTION		: string := "480p"		-- 27.000MHz,720x480,60Hz/59.94Hz,4:3/16:9
--		RESOLUTION		: string := "720p"		-- 74.250MHz,1280x720,60Hz/59.94Hz,16:9
--		RESOLUTION		: string := "1080p/30"	-- 74.250MHz,1920x1080,30Hz/29.97Hz,16:9
	);
	port (
		clk_in		: in  std_logic;		-- input clock 30MHz

--		test_hsync_n	: out std_logic;		-- GPIO1_D31
--		test_vsync_n	: out std_logic;		-- GPIO1_D30
--		test_enable		: out std_logic;		-- GPIO1_D29
--		test_locked		: out std_logic;		-- LED[0]

		dvi_data0_p		: out std_logic;		-- GPIO1_D16
		dvi_data0_n		: out std_logic;		-- GPIO1_D17
		dvi_data1_p		: out std_logic;		-- GPIO1_D20
		dvi_data1_n		: out std_logic;		-- GPIO1_D21
		dvi_data2_p		: out std_logic;		-- GPIO1_D13
		dvi_data2_n		: out std_logic;		-- GPIO1_D12
		dvi_clock_p		: out std_logic;		-- GPIO1_D9
		dvi_clock_n		: out std_logic;			-- GPIO1_D8
		
		-- GPMC
		AD							:	inout	std_logic_vector(15 downto 0)	;
		ADV_L						:	in	std_logic							;
		WE_L						:	in	std_logic							;
		RD_L						:	in	std_logic							;	--OEN
		CS_L						:	in	std_logic							;
		
		-- SDRAM
		SDRAM_DQ					:	inout	std_logic_vector(15 downto 0)	;
		SDRAM_ADDR					:	out	std_logic_vector(12 downto 0)		;
		SDRAM_LDQM					:	out	std_logic							;
		SDRAM_UDQM					:	out	std_logic							;
		SDRAM_WE_N					:	out	std_logic							;
		SDRAM_CAS_N					:	out	std_logic							;
		SDRAM_RAS_N					:	out	std_logic							;
		SDRAM_CS_N					:	out	std_logic							;
		SDRAM_BA_0					:	out	std_logic							;
		SDRAM_BA_1					:	out	std_logic							;
		SDRAM_CLK					:	out	std_logic							;
		SDRAM_CKE					:	out	std_logic							;
		
		-- serial Flash
		FLASH_DATA					:	inout std_logic_vector(3 downto 0)  := (others => 'X'); -- conduit_dataout
		FLASH_DCLK					:	out   std_logic;                                        -- conduit_dclk_out
		FLASH_nCS					:	out   std_logic_vector(0 downto 0) ;                     -- conduit_ncs
		
		-- UART
		UART_TXD					:	out	std_logic							;
		UART_RXD					:	in	std_logic							;
		
		LED							:	out	std_logic_vector(1 downto 0)		;
		
		SW_TACT						:	in	std_logic_vector(1 downto 0)		
		
		
	);
end PRJ_TOP;

architecture RTL of PRJ_TOP is
	signal reset_n_sig		: std_logic;
	signal videoclk_sig		: std_logic;
	signal locked_sig		: std_logic;

	signal hsync_sig		: std_logic;
	signal vsync_sig		: std_logic;
	signal hblank_sig		: std_logic;
	signal vblank_sig		: std_logic;
	signal de_sig			: std_logic;
	signal hcount_sig		: std_logic_vector(10 downto 0);
	signal vcount_sig		: std_logic_vector(9 downto 0);

	signal pix_r_sig		: std_logic_vector(7 downto 0);
	signal pix_g_sig		: std_logic_vector(7 downto 0);
	signal pix_b_sig		: std_logic_vector(7 downto 0);

	signal	clk_dot_sig		:	std_logic	;
	signal	clk_ser_sig		:	std_logic	;
	signal	clk_qsys		:	std_logic	;
	signal	clk_sdram		:	std_logic	;
	
	signal	areset			:	std_logic	;
	signal	reset			:	std_logic	;
	
	
	signal		reset_n				:	std_logic								;
	
	signal	wLED0			:	std_logic	;
	signal	wCnt0			:	integer range 0 to 1000000000;
	
	signal	wLED1			:	std_logic	;
	signal	wCnt1			:	integer range 0 to 1000000000;
	
	component	FRAME_BUF	is
		port	(
				CLK							:	in	std_logic							;
				VIDEO_CLK					:	in	std_logic							;
				DOT_CLK						:	in	std_logic							;
				RST_L						:	in	std_logic							;
				
				AD							:	inout	std_logic_vector(7 downto 0)	;
				ADV_L						:	in	std_logic							;
				WE_L						:	in	std_logic							;
				RD_L						:	in	std_logic							;	--OEN
				CS_L						:	in	std_logic							;
				
				iBLUE						:	out	std_logic_vector(7 downto 0)		;
				iGREEN						:	out	std_logic_vector(7 downto 0)		;
				iRED						:	out	std_logic_vector(7 downto 0)		;
				iDE							:	out	std_logic							;
				iHSYNC						:	out	std_logic							;
				iVSYNC						:	out	std_logic							;
				
				-- SDRAM
				SDRAM_DQ					:	inout	std_logic_vector(15 downto 0)	;
				SDRAM_ADDR					:	out	std_logic_vector(12 downto 0)		;
				SDRAM_LDQM					:	out	std_logic							;
				SDRAM_UDQM					:	out	std_logic							;
				SDRAM_WE_N					:	out	std_logic							;
				SDRAM_CAS_N					:	out	std_logic							;
				SDRAM_RAS_N					:	out	std_logic							;
				SDRAM_CS_N					:	out	std_logic							;
				SDRAM_BA_0					:	out	std_logic							;
				SDRAM_BA_1					:	out	std_logic							;
				SDRAM_CLK					:	out	std_logic							;
				SDRAM_CKE					:	out	std_logic							
				);
	end	component;
	
	component pll_video_sd
	PORT (
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;	--27MHz
		c1		: OUT STD_LOGIC ;	--27MHz
		c2		: OUT STD_LOGIC ;	--135MHz
		c3		: OUT STD_LOGIC ;	
		c4		: OUT STD_LOGIC ;	
		locked		: OUT STD_LOGIC 
	);
	end component;
	
	
	component pll_video_vga IS
		PORT
		(
			areset		: IN STD_LOGIC  := '0';
			inclk0		: IN STD_LOGIC  := '0';
			c0		: OUT STD_LOGIC ;
			c1		: OUT STD_LOGIC ;
			c2		: OUT STD_LOGIC ;
			c3		: OUT STD_LOGIC ;
			locked		: OUT STD_LOGIC 
		);
	END component;

	component dvi_tx_pdiff
	generic(
		RESET_LEVEL		: std_logic := '1';	-- Positive logic reset
		RESOLUTION		: string := "VGA"	-- 25.175MHz
	);
	port(
		reset		: in  std_logic;
		clk			: in  std_logic;		-- Rise edge drive clock
		clk_dot_sig	: in  std_logic;
		clk_ser_sig	: in  std_logic;
		reset_n_sig	: in  std_logic;

		test_data0	: out std_logic_vector(9 downto 0);
		test_data1	: out std_logic_vector(9 downto 0);
		test_data2	: out std_logic_vector(9 downto 0);
		test_locked	: out std_logic;

		dvi_de		: in  std_logic;
		dvi_blu		: in  std_logic_vector(7 downto 0);
		dvi_grn		: in  std_logic_vector(7 downto 0);
		dvi_red		: in  std_logic_vector(7 downto 0);
		dvi_hsync	: in  std_logic;
		dvi_vsync	: in  std_logic;
		dvi_ctl		: in  std_logic_vector(3 downto 0) :="0000";

		data0_p		: out std_logic;
		data0_n		: out std_logic;
		data1_p		: out std_logic;
		data1_n		: out std_logic;
		data2_p		: out std_logic;
		data2_n		: out std_logic;
		clock_p		: out std_logic;
		clock_n		: out std_logic
	);
	end component;
	
	
	
begin

--	test_hsync_n <= not hsync_sig;
--	test_vsync_n <= not vsync_sig;
--	test_enable  <= de_sig;
--	test_locked  <= locked_sig;
	
	process (clk_in) begin
		if(clk_in'event and clk_in='1') then
			reset_n		<=	SW_TACT(0)	;
			areset		<=	not reset_n	;
		end if;
	end process;
	
	--reset		<=	not reset_n_sig	;
	
	pll_inst : pll_video_sd PORT MAP (
		areset		=>	areset			,	--	: IN STD_LOGIC  := '0';
		inclk0		=>	clk_in			,	--	: IN STD_LOGIC  := '0';
		c0			=>	videoclk_sig		,	--	: OUT STD_LOGIC ;	--27MHz
		c1			=>	clk_dot_sig			,	--	: OUT STD_LOGIC ;	--27MHz
		c2			=>	clk_ser_sig			,	--	: OUT STD_LOGIC ;	--135MHz
		c3			=>	clk_qsys			,	--	: OUT STD_LOGIC ;
		c4			=>	clk_sdram			,	--	: OUT STD_LOGIC ;	
		locked		=>	reset_n_sig				--	: OUT STD_LOGIC 
	);
	
	--pll_inst : pll_video_vga PORT MAP (
	--	areset		=>	areset			,	--	: IN STD_LOGIC  := '0';
	--	inclk0		=>	clk_in			,	--	: IN STD_LOGIC  := '0';
	--	c0			=>	videoclk_sig		,	--	: OUT STD_LOGIC ;	--25.175MHz
	--	c1			=>	clk_dot_sig			,	--	: OUT STD_LOGIC ;	--25.175MHz
	--	c2			=>	clk_ser_sig			,	--	: OUT STD_LOGIC ;	--125.875MHz
	--	c3			=>	clk_qsys			,	--	: OUT STD_LOGIC ;
	--	locked		=>	reset_n_sig				--	: OUT STD_LOGIC 
	--);

	FRAME_BUF_U	:	FRAME_BUF
		port map	(
				CLK						=>	clk_qsys				,	--	:	in	std_logic							;
				VIDEO_CLK				=>	videoclk_sig			,	--	:	in	std_logic							;
				DOT_CLK					=>	clk_dot_sig				,	--			:	in	std_logic							;	--	30MHz
				--RST_L					=>	reset_n					,	--	:	in	std_logic							;
				RST_L					=>	reset_n_sig				,
				
				
				AD						=>	AD(7 downto 0)			,	--	:	inout	std_logic_vector(15 downto 0)	;
				ADV_L					=>	ADV_L					,	--	:	in	std_logic							;
				WE_L					=>	WE_L					,	--	:	in	std_logic							;
				RD_L					=>	RD_L					,	--	:	in	std_logic							;	--OEN
				CS_L					=>	CS_L					,	--	:	in	std_logic							;
				
				iBLUE					=>	pix_b_sig						,	--	:	out	std_logic_vector(8 downto 0)		;
				iGREEN					=>	pix_g_sig						,	--	:	out	std_logic_vector(8 downto 0)		;
				iRED					=>	pix_r_sig						,	--	:	out	std_logic_vector(8 downto 0)		;
				iDE						=>	de_sig							,	--	:	out	std_logic							;
				iHSYNC					=>	hsync_sig						,	--	:	out	std_logic							;
				iVSYNC					=>	vsync_sig						,	--	:	out	std_logic							
				
				-- SDRAM
				SDRAM_DQ				=>	SDRAM_DQ				,	--		:	inout	std_logic_vector(15 downto 0)	;
				SDRAM_ADDR				=>	SDRAM_ADDR				,	--		:	out	std_logic_vector(12 downto 0)		;
				SDRAM_LDQM				=>	SDRAM_LDQM				,	--		:	out	std_logic							;
				SDRAM_UDQM				=>	SDRAM_UDQM				,	--		:	out	std_logic							;
				SDRAM_WE_N				=>	SDRAM_WE_N				,	--		:	out	std_logic							;
				SDRAM_CAS_N				=>	SDRAM_CAS_N				,	--		:	out	std_logic							;
				SDRAM_RAS_N				=>	SDRAM_RAS_N				,	--		:	out	std_logic							;
				SDRAM_CS_N				=>	SDRAM_CS_N				,	--		:	out	std_logic							;
				SDRAM_BA_0				=>	SDRAM_BA_0				,	--		:	out	std_logic							;
				SDRAM_BA_1				=>	SDRAM_BA_1				,	--		:	out	std_logic							;
				SDRAM_CLK				=>	open					,	--		:	out	std_logic							;
				SDRAM_CKE				=>	SDRAM_CKE					--		:	out	std_logic							
				
				);

				
	AD(15 downto 8)	<=	(others => 'Z')	;
	
	SDRAM_CLK			<=	clk_sdram	;
	
	U1 : dvi_tx_pdiff
	generic map (
		RESOLUTION	=> RESOLUTION
	)
	port map (
		reset		=> reset,
		clk			=> videoclk_sig,
		clk_dot_sig	=>	clk_dot_sig		,
		clk_ser_sig	=>	clk_ser_sig		,
		reset_n_sig	=>	reset_n_sig		,
		
		test_locked	=> locked_sig,

		dvi_de		=> de_sig,
		dvi_blu		=> pix_b_sig,
		dvi_grn		=> pix_g_sig,
		dvi_red		=> pix_r_sig,
		--dvi_blu		=> x"FF",
		--dvi_grn		=> x"00",
		--dvi_red		=> x"00",
		dvi_hsync	=> hsync_sig,
		dvi_vsync	=> vsync_sig,
		dvi_ctl		=> "0000",

		data0_p		=> dvi_data0_p,
		data0_n		=> dvi_data0_n,
		data1_p		=> dvi_data1_p,
		data1_n		=> dvi_data1_n,
		data2_p		=> dvi_data2_p,
		data2_n		=> dvi_data2_n,
		clock_p		=> dvi_clock_p,
		clock_n		=> dvi_clock_n
	);

	
	
	--DIGITAL_IO		<=	(others => 'Z')	;
	
	-- UART
	--UART_TXD		<= UART_RXD		;
	
	
	
	process( clk_ser_sig , areset )
	begin
		if ( areset = '1' ) then
			wCnt0	<=	0		;
			wLED0	<=	'0'		;
		elsif ( clk_ser_sig'event and clk_ser_sig = '1' ) then
			if(wCnt0 /= 135000000)then
				wCnt0	<=	wCnt0 + 1;
			else
				wCnt0	<=	0	;
			end if;
			if(wCnt0 = 135000000)then
				wLED0	<=	not wLED0	;
			end if;
		end if;
	end process;
	
	process( clk_ser_sig , areset )
	begin
		if ( areset = '1' ) then
			wCnt1	<=	0		;
			wLED1	<=	'0'		;
		elsif ( clk_ser_sig'event and clk_ser_sig = '1' ) then
			if(wCnt1 /= 375000000)then
				wCnt1	<=	wCnt1 + 1;
			else
				wCnt1	<=	0	;
			end if;
			if(wCnt1 = 375000000)then
				wLED1	<=	not wLED1	;
			end if;
		end if;
	end process;
	
	
	LED(1)		<=	wLED1	;
	LED(0)  <= wLED0;
	
	--LED(0)		<=	not SW_TACT(0)	;
	--LED(1)		<=	not SW_TACT(1)	;
	
		
	
end RTL;



----------------------------------------------------------------------
--   Copyright (C)2010-2013 J-7SYSTEM Works.  All rights Reserved.  --
----------------------------------------------------------------------

