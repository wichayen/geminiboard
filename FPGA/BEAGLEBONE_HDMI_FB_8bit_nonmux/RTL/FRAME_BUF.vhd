	library		ieee,std;
	use			ieee.std_logic_1164.all	;
	use			ieee.std_logic_unsigned.all;
	use			ieee.std_logic_arith.all;
	use			ieee.std_logic_misc.all;
	
	
	use			work.General_PKG.all;
--------------------------------------------------------
	-- address
	-- 0x0000 -> frame buffer data (auto increment)
	-- 
	-- when read there will automatically reset address
	--
	
	entity	FRAME_BUF	is
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
	end	FRAME_BUF;

	architecture	arcFRAME_BUF	of	FRAME_BUF	is
--	------------------------------------------------------------------	--
--	*component															--
--	------------------------------------------------------------------	--
	component	GPMC_IF	is
		port	(
				CLK							:	in	std_logic							;
				RST_L						:	in	std_logic							;
				
				AD							:	inout	std_logic_vector(7 downto 0)	;
				ADV_L						:	in	std_logic							;
				WE_L						:	in	std_logic							;
				RD_L						:	in	std_logic							;	--OEN
				CS_L						:	in	std_logic							;
				
				--	system interface
				iAddr						:	out	std_logic_vector(7 downto 0)		;
				iDataRd						:	in	std_logic_vector(7 downto 0)		;
				iDataWr						:	out	std_logic_vector(7 downto 0)		;
				ipWr						:	out	std_logic							;
				ipRd						:	out	std_logic							;
				iCS							:	out	std_logic								--unused
				
				);
	end	component;
	
	component GPMCFIFO IS
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdreq		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		empty		: OUT STD_LOGIC ;
		full		: OUT STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		usedw		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	);
END component;

	component MyQsys is
		port (
			AvalonSimpleMaster_0_avm_m0_address     : in    std_logic_vector(31 downto 0) := (others => '0'); -- AvalonSimpleMaster_0_avm_m0.address
			AvalonSimpleMaster_0_avm_m0_read        : in    std_logic                     := '0';             --                            .read
			AvalonSimpleMaster_0_avm_m0_readdatavalid : out std_logic;
			AvalonSimpleMaster_0_avm_m0_waitrequest : out   std_logic;                                        --                            .waitrequest
			AvalonSimpleMaster_0_avm_m0_readdata    : out   std_logic_vector(15 downto 0);                    --                            .readdata
			AvalonSimpleMaster_0_avm_m0_write       : in    std_logic                     := '0';             --                            .write
			AvalonSimpleMaster_0_avm_m0_writedata   : in    std_logic_vector(15 downto 0) := (others => '0'); --                            .writedata
			AvalonSimpleMaster_0_reset_reset        : out   std_logic;                                        --  AvalonSimpleMaster_0_reset.reset
			clk_clk                                 : in    std_logic                     := '0';             --                         clk.clk
			clock_bridge_0_out_clk_clk                : out   std_logic                    ;                     -- clk
			new_sdram_controller_0_wire_addr        : out   std_logic_vector(11 downto 0);                    -- new_sdram_controller_0_wire.addr
			new_sdram_controller_0_wire_ba          : out   std_logic_vector(1 downto 0);                     --                            .ba
			new_sdram_controller_0_wire_cas_n       : out   std_logic;                                        --                            .cas_n
			new_sdram_controller_0_wire_cke         : out   std_logic;                                        --                            .cke
			new_sdram_controller_0_wire_cs_n        : out   std_logic;                                        --                            .cs_n
			new_sdram_controller_0_wire_dq          : inout std_logic_vector(15 downto 0) := (others => '0'); --                            .dq
			new_sdram_controller_0_wire_dqm         : out   std_logic_vector(1 downto 0);                     --                            .dqm
			new_sdram_controller_0_wire_ras_n       : out   std_logic;                                        --                            .ras_n
			new_sdram_controller_0_wire_we_n        : out   std_logic;                                        --                            .we_n
			reset_reset_n                           : in    std_logic                     := '0'              --                       reset.reset_n
		);
	end component MyQsys;

	
component VGAFIFO IS
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdclk		: IN STD_LOGIC ;
		rdreq		: IN STD_LOGIC ;
		wrclk		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdempty		: OUT STD_LOGIC ;
		rdusedw		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		wrfull		: OUT STD_LOGIC ;
		wrusedw		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
end component;

	component vga_syncgen is
	generic (
		H_TOTAL		: integer := 800;
		H_SYNC		: integer := 96;
		H_BACKP		: integer := 48;
		H_ACTIVE	: integer := 640;
		V_TOTAL		: integer := 525;
		V_SYNC		: integer := 2;
		V_BACKP		: integer := 33;
		V_ACTIVE	: integer := 480
	);
	port (
		reset		: in  std_logic;		-- active high
		video_clk	: in  std_logic;		-- typ 25.175MHz

		scan_ena	: in  std_logic;		-- framebuff scan enable
		dither_ena	: in  std_logic;		-- dither enable

		test_hcount	: out std_logic_vector(10 downto 0);	-- H:0～2047
		test_vcount	: out std_logic_vector(9 downto 0);		-- V:0～1023

		framestart	: out std_logic;
		linestart	: out std_logic;
		line_reg_bf1cyc	: out std_logic;
		line_reg_bf1cyc_10clk	: out std_logic;
		dither		: out std_logic;		-- RGB444 dither signal
		pixelena	: out std_logic;		-- pixel readout active
		pixelena_bf1clk: out std_logic;

		hsync		: out std_logic;
		vsync		: out std_logic;
		hblank		: out std_logic;
		vblank		: out std_logic
	);
end component;

--	------------------------------------------------------------------	--
--	*constant	kName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	constant	kFB_PIXEL_ADDR_UU			:	std_logic_vector(7 downto 0)		:=	x"10"	;	--	(31 downto 24)	0x20/2 = 0x10
	constant	kFB_PIXEL_ADDR_UL			:	std_logic_vector(7 downto 0)		:=	x"12"	;	--	(23 downto 16)		
	constant	kFB_PIXEL_ADDR_LU			:	std_logic_vector(7 downto 0)		:=	x"14"	;	--	(15 downto 8)		
	constant	kFB_PIXEL_ADDR_LL			:	std_logic_vector(7 downto 0)		:=	x"16"	;	--	(7 downto 0)		
	constant	kFB_BASE_ADDR				:	std_logic_vector(7 downto 0)		:=	x"00"	;
	
	constant	k480p_COL_NUM				:	integer								:=	720	;
	constant	kVGA_COL_NUM				:	integer								:=	640	;
	
--	------------------------------------------------------------------	--
--	*signal		wName						:	size								:=	; -- 
--	------------------------------------------------------------------	--
	signal		wGPMCFrameWrCnt				:	std_logic_vector(31 downto 0)		;
	
	signal		wAddr						:	std_logic_vector(7 downto 0)		;
	signal		wDataRd						:	std_logic_vector(7 downto 0)		;
	signal		wDataWr						:	std_logic_vector(7 downto 0)		;
	signal		wGPMCWrCnt					:	integer range 0 to 3 				;
	signal		wpWr						:	std_logic							;
	signal		wpRd						:	std_logic							;
	signal		wCS							:	std_logic							;	--unused
	
	signal		wpGPMCFIFOWrEn				:	std_logic							;
	signal		wGPMCFIFOEmpty				:	std_logic							;
	signal		wGPMCFIFOWrData				:	std_logic_vector(15 downto 0)		;
	signal		wGPMCFIFORdData				:	std_logic_vector(15 downto 0)		;
	signal		wGPMCFIFORdEn				:	std_logic							;
	signal		wGPMCFIFORdEn_DL1			:	std_logic							;
	signal		wpGPMCFIFORdEn				:	std_logic							;
	signal		wpGPMCFIFORdEn_DL1			:	std_logic							;
	
	signal		wAvalonWrBusy					:	std_logic							;
	
	signal	AvalonSimpleMaster_0_avm_m0_address      :	std_logic_vector(31 downto 0) := (others => '0'); -- AvalonSimpleMaster_0_avm_m0.address
	signal	AvalonSimpleMaster_0_avm_m0_read         :	std_logic                     := '0';             --                            .read
	signal	AvalonSimpleMaster_0_avm_m0_readdatavalid	:	std_logic	;
	signal	AvalonSimpleMaster_0_avm_m0_waitrequest  :	std_logic;                                        --                            .waitrequest
	signal	AvalonSimpleMaster_0_avm_m0_readdata     :	std_logic_vector(15 downto 0);                    --                            .readdata
	signal	AvalonSimpleMaster_0_avm_m0_write        :	std_logic                     := '0';             --                            .write
	signal	AvalonSimpleMaster_0_avm_m0_writedata    :	std_logic_vector(15 downto 0) := (others => '0'); --                            .writedata
	signal	AvalonSimpleMaster_0_reset_reset         :	std_logic;                                        --  AvalonSimpleMaster_0_reset.reset
	
	signal	AvalonWrAddress      :	std_logic_vector(31 downto 0) := (others => '0'); -- AvalonSimpleMaster_0_avm_m0.address
	signal	AvalonRdAddress      :	std_logic_vector(31 downto 0) := (others => '0'); -- AvalonSimpleMaster_0_avm_m0.address
	signal	wAvalonWrReq				:	std_logic	;
	signal	wAvalonRdReq				:	std_logic	;
	signal	wAvalonRdReq_DL1			:	std_logic	;
	signal	wpAvalonRdReq				:	std_logic	;
	signal	wFrameBufEn					:	std_logic	;
	--signal	wpAvalonRdAddrSet				:	std_logic	;
	
	
	signal	wRdCnt									:	integer range 0 to 4096			;
	
	signal	new_sdram_controller_0_wire_ba				:	std_logic_vector(1 downto 0);
	signal	new_sdram_controller_0_wire_dqm				:	std_logic_vector(1 downto 0);
	
	
	signal	hsync_sig							:	std_logic	;
	signal	vsync_sig							:	std_logic	;
	signal	vsync_sig_DL1						:	std_logic	;
	signal	vsync_sig_SYNC						:	std_logic	;
	signal	vsync_sig_SYNC_DL1					:	std_logic	;

	signal	reset			:	std_logic	;
	
	
	signal	wVGAFIFOWrData		:	std_logic_vector(15 downto 0);
	signal	wVGAFIFOWrEn		:	std_logic	;
	
	signal	wVGAFIFORdData		:	std_logic_vector(15 downto 0);
	signal	wVGAFIFORdEn		:	std_logic	;
	
	signal	wVGAwrusedw			:	std_logic_vector(11 downto 0);
	signal	wVGAFIFOClr			:	std_logic	;
	
	signal	vblank				:	std_logic	;
	signal	hblank				:	std_logic	;
	signal	wvsync_sig_SYNC		:	std_logic	;
	signal	wvsync_sig_SYNC_DL1	:	std_logic	;
	signal	pixelena_bf1clk		:	std_logic	;
	signal	pixelena			:	std_logic	;
	
	signal	line_reg_bf1cyc			:	std_logic	;
	signal	line_reg_bf1cyc_SYNC		:	std_logic	;
	signal	line_reg_bf1cyc_SYNC_DL1	:	std_logic	;
	
	signal	line_reg_bf1cyc_10clk	:	std_logic	;
	signal	line_reg_bf1cyc_10clk_SYNC	:	std_logic	;
	
	
	signal	test_vcount	: std_logic_vector(9 downto 0);
	signal	wLineCnt			:	integer range 0 to 2047	;
--====================================================--

--====================================================--
	
	
	begin
--====================================================--
--[Port Map] 
--====================================================--
	AvalonSimpleMaster_0_reset_reset	<=	not RST_L;
	
	GPMC_IF_U	:	GPMC_IF
		port map	(
				CLK							=>	CLK					,	--	:	in	std_logic							;
				RST_L						=>	RST_L				,	--	:	in	std_logic							;
				
				AD							=>	AD					,	--	:	inout	std_logic_vector(15 downto 0)	;
				ADV_L						=>	ADV_L				,	--	:	in	std_logic							;
				WE_L						=>	WE_L				,	--	:	in	std_logic							;
				RD_L						=>	RD_L				,	--	:	in	std_logic							;	--OEN
				CS_L						=>	CS_L				,	--	:	in	std_logic							;
				
				--	system interface        =>			,	--	
				iAddr						=>	wAddr				,	--	:	out	std_logic_vector(15 downto 0)		;
				iDataRd						=>	wDataRd				,	--	:	in	std_logic_vector(15 downto 0)		;
				iDataWr						=>	wDataWr				,	--	:	out	std_logic_vector(15 downto 0)		;
				ipWr						=>	wpWr				,	--	:	out	std_logic							;
				ipRd						=>	wpRd				,	--	:	out	std_logic							;
				iCS							=>	open						--	:	out	std_logic								--unused
				);
	
	GPMCFIFO_U	:	GPMCFIFO
	PORT map
	(
		aclr		=>	'0'					,	--	: IN STD_LOGIC ;
		clock		=>	CLK					,	--	: IN STD_LOGIC ;
		data		=>	wGPMCFIFOWrData		,	--	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdreq		=>	wpGPMCFIFORdEn		,	--	: IN STD_LOGIC ;
		wrreq		=>	wpGPMCFIFOWrEn		,	--	: IN STD_LOGIC ;
		empty		=>	wGPMCFIFOEmpty		,	--	: OUT STD_LOGIC ;
		full		=>	open				,	--	: OUT STD_LOGIC ;
		q			=>	wGPMCFIFORdData		,	--	: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		usedw		=>	open					--	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);

	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			AvalonWrAddress	<=	(others => '0');
		elsif ( CLK'event and CLK = '1' ) then
			if(wpRd = '1')then
				AvalonWrAddress	<=	(others => '0');
			elsif(wpGPMCFIFORdEn_DL1 = '1')then
				--if(AvalonWrAddress /= x"000A_8BFE")then	--	(345600-1)*2
				--	AvalonWrAddress	<=	AvalonWrAddress + 2;
				--else
				--	AvalonWrAddress	<=	(others => '0')	;
				--end if;
				AvalonWrAddress	<=	AvalonWrAddress + 2;	--???
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wDataRd	<=		(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			if(wpRd = '1')then
				wDataRd	<=	wGPMCFrameWrCnt(31 downto 24)	;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wGPMCFrameWrCnt		<=	(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			if(wpWr = '1')then
				wGPMCFrameWrCnt	<=	(others => '0')	;
			else
				if(wpGPMCFIFORdEn = '1')then
					wGPMCFrameWrCnt	<=	wGPMCFrameWrCnt + 2;
				end if;
			end if;
		end if;
	end process;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wGPMCWrCnt		<=	0	;
			wGPMCFIFOWrData	<=	(others => '0');
		elsif ( CLK'event and CLK = '1' ) then
			if(wpWr = '1')then
				if(wpRd = '1')then
					wGPMCWrCnt	<=	0	;
				else
					if(wGPMCWrCnt /= 1)then
						wGPMCWrCnt	<=	wGPMCWrCnt + 1;
					else
						wGPMCWrCnt	<=	0	;
					end if;
					wGPMCFIFOWrData	<=	wDataWr & wGPMCFIFOWrData(15 downto 8)	;
				end if;
			end if;
		end if;
	end process;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wpGPMCFIFOWrEn	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(wpWr = '1')then
			--if(wpWr = '1')then	--??? for test
			--if(wpWr = '1' and wAddr(15) = '1')then	--??? for test
			--if(wpWr = '1' and wAddr = x"4000")then	--??? for test
				if(wGPMCWrCnt = 1)then
					wpGPMCFIFOWrEn	<=	'1'	;
					--wGPMCFIFOWrData	<=	wDataWr	;
				end if;
			else
				wpGPMCFIFOWrEn	<=	'0'	;
			end if;
		end if;
	end process;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			line_reg_bf1cyc_10clk_SYNC	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			line_reg_bf1cyc_10clk_SYNC	<=	line_reg_bf1cyc_10clk	;
		end if;
	end process;
	
	
	--wAvalonWrBusy	<=	wAvalonRdReq or AvalonSimpleMaster_0_avm_m0_read or AvalonSimpleMaster_0_avm_m0_readdatavalid or line_reg_bf1cyc_10clk_SYNC;
	--wAvalonWrBusy	<=	pixelena_bf1clk	;
	wAvalonWrBusy	<=	wpAvalonRdReq or AvalonSimpleMaster_0_avm_m0_read or AvalonSimpleMaster_0_avm_m0_readdatavalid or line_reg_bf1cyc_10clk_SYNC;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wGPMCFIFORdEn	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(AvalonSimpleMaster_0_avm_m0_write = '1')then
				wGPMCFIFORdEn	<=	'0'	;
			elsif(wGPMCFIFOEmpty = '0' and wAvalonWrBusy = '0')then
				wGPMCFIFORdEn	<=	'1'	;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wGPMCFIFORdEn_DL1	<=	'0'	;
			wpGPMCFIFORdEn		<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			wGPMCFIFORdEn_DL1	<=	wGPMCFIFORdEn	;
			if(fRisEdge(wGPMCFIFORdEn, wGPMCFIFORdEn_DL1))then
				wpGPMCFIFORdEn	<=	'1'	;
			else
				wpGPMCFIFORdEn	<=	'0'	;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wpGPMCFIFORdEn_DL1		<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			wpGPMCFIFORdEn_DL1	<=	wpGPMCFIFORdEn	;
		end if;
	end process;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wAvalonWrReq	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(wpGPMCFIFORdEn_DL1 = '1')then
				wAvalonWrReq	<=	'1'	;
			elsif(AvalonSimpleMaster_0_avm_m0_write = '1')then
				wAvalonWrReq	<=	'0'	;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			AvalonSimpleMaster_0_avm_m0_write	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(wAvalonWrReq = '1')then
				AvalonSimpleMaster_0_avm_m0_write	<=	'1'	;
			elsif(AvalonSimpleMaster_0_avm_m0_waitrequest = '0')then
				AvalonSimpleMaster_0_avm_m0_write	<=	'0'	;
			end if;
		end if;
	end process;
	--AvalonSimpleMaster_0_avm_m0_writedata		<=	wDataWr	;
	AvalonSimpleMaster_0_avm_m0_writedata		<=	wGPMCFIFORdData	;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wFrameBufEn	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			--if(wpWr = '1' and wAddr = x"F000")then
			--	wFrameBufEn	<=	wDataWr(0)	;
			--end if;
			wFrameBufEn	<=	'1'	;	--	fix to enable
		end if;
	end process;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			line_reg_bf1cyc_SYNC	<=	'0'	;
			line_reg_bf1cyc_SYNC_DL1	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			line_reg_bf1cyc_SYNC	<=	line_reg_bf1cyc	;
			line_reg_bf1cyc_SYNC_DL1	<=	line_reg_bf1cyc_SYNC	;
		end if;
	end process;
	
	--process( CLK , RST_L )
	--begin
	--	if ( RST_L = '0' ) then
	--		wAvalonRdReq	<=	'0'	;
	--	elsif ( CLK'event and CLK = '1' ) then
	--		if(AvalonSimpleMaster_0_avm_m0_read = '1')then
	--			wAvalonRdReq	<=	'0'	;
	--		--elsif(wVGAwrusedw(wVGAwrusedw'high) = '0')then
	--		--lsif(conv_integer(wVGAwrusedw) >= 720)then
	--		elsif(fRisEdge(line_reg_bf1cyc_SYNC, line_reg_bf1cyc_SYNC_DL1))then
	--			if(wFrameBufEn = '1')then
	--				wAvalonRdReq	<=	'1'	;
	--			end if;
	--		end if;
	--	end if;
	--end process;
	
	--process( CLK , RST_L )
	--begin
	--	if ( RST_L = '0' ) then
	--		wAvalonRdReq	<=	'0'	;
	--	elsif ( CLK'event and CLK = '1' ) then
	--		if(fRisEdge(line_reg_bf1cyc_SYNC, line_reg_bf1cyc_SYNC_DL1))then
	--			if(wFrameBufEn = '1')then
	--				wAvalonRdReq	<=	'1'	;
	--			end if;
	--		--elsif(AvalonSimpleMaster_0_avm_m0_read = '1')then
	--		elsif(AvalonSimpleMaster_0_avm_m0_waitrequest = '0')then
	--			wAvalonRdReq	<=	'0'	;
	--		end if;
	--	end if;
	--end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wAvalonRdReq_DL1	<=	'0'	;
			wpAvalonRdReq	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			wAvalonRdReq_DL1	<=	wAvalonRdReq	;
			--if(fRisEdge(wAvalonRdReq, wAvalonRdReq_DL1))then
			if(fRisEdge(line_reg_bf1cyc_SYNC, line_reg_bf1cyc_SYNC_DL1))then	--???
				wpAvalonRdReq	<=	'1'	;
			else
				wpAvalonRdReq	<=	'0'	;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			AvalonSimpleMaster_0_avm_m0_read	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(wRdCnt = k480p_COL_NUM-1)then
			--if(wRdCnt = kVGA_COL_NUM-1)then
				AvalonSimpleMaster_0_avm_m0_read	<=	'0'	;
			elsif(wpAvalonRdReq = '1')then
				AvalonSimpleMaster_0_avm_m0_read	<=	'1'	;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wvsync_sig_SYNC		<=	'0'	;
			wvsync_sig_SYNC_DL1	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			wvsync_sig_SYNC		<=	vsync_sig	;
			wvsync_sig_SYNC_DL1	<=	wvsync_sig_SYNC	;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wLineCnt	<=	0	;
		elsif ( CLK'event and CLK = '1' ) then
			if(fFallEdge(wvsync_sig_SYNC, wvsync_sig_SYNC_DL1))then
				wLineCnt	<=	0	;
			elsif(fRisEdge(line_reg_bf1cyc_SYNC, line_reg_bf1cyc_SYNC_DL1))then	--???
				wLineCnt	<=	wLineCnt + 1;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			AvalonRdAddress						<=	(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			--if(wpAvalonRdAddrSet = '1')then
			--if(fFallEdge(wvsync_sig_SYNC, wvsync_sig_SYNC_DL1))then
			--	AvalonRdAddress								<=	x"0000_0000"	;
			if(fRisEdge(line_reg_bf1cyc_SYNC, line_reg_bf1cyc_SYNC_DL1))then	--???
				AvalonRdAddress				<=	conv_std_logic_vector((wLineCnt * k480p_COL_NUM * 2),32)	;
				--AvalonRdAddress				<=	conv_std_logic_vector((wLineCnt * kVGA_COL_NUM * 2),32)	;
			elsif(	AvalonSimpleMaster_0_avm_m0_read = '1' and
					AvalonSimpleMaster_0_avm_m0_waitrequest = '0' )then
				--AvalonRdAddress								<=	AvalonSimpleMaster_0_avm_m0_address + 2;
				AvalonRdAddress								<=	AvalonRdAddress + 2;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			AvalonSimpleMaster_0_avm_m0_address	<=	(others => '0')	;
		elsif ( CLK'event and CLK = '1' ) then
			if(wpAvalonRdReq = '1')then
				AvalonSimpleMaster_0_avm_m0_address			<=	AvalonRdAddress	;
			elsif(	AvalonSimpleMaster_0_avm_m0_read = '1' and
					AvalonSimpleMaster_0_avm_m0_waitrequest = '0' )then
				AvalonSimpleMaster_0_avm_m0_address			<=	AvalonSimpleMaster_0_avm_m0_address + 2;
			elsif(wpGPMCFIFORdEn = '1')then
				AvalonSimpleMaster_0_avm_m0_address			<=	AvalonWrAddress		;
			end if;
		end if;
	end process;
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wRdCnt	<=	0;
		elsif ( CLK'event and CLK = '1' ) then
			if(wpAvalonRdReq = '1')then
				wRdCnt	<=	0	;
			elsif(	AvalonSimpleMaster_0_avm_m0_read = '1' and
					AvalonSimpleMaster_0_avm_m0_waitrequest = '0' )then
				wRdCnt	<=	wRdCnt + 1	;
			end if;
		end if;
	end process;
	
	u0 : component MyQsys
		port map (
			AvalonSimpleMaster_0_avm_m0_address     => AvalonSimpleMaster_0_avm_m0_address         ,
			AvalonSimpleMaster_0_avm_m0_read        => AvalonSimpleMaster_0_avm_m0_read            ,
			AvalonSimpleMaster_0_avm_m0_readdatavalid => AvalonSimpleMaster_0_avm_m0_readdatavalid  ,
			AvalonSimpleMaster_0_avm_m0_waitrequest => AvalonSimpleMaster_0_avm_m0_waitrequest     ,
			AvalonSimpleMaster_0_avm_m0_readdata    => AvalonSimpleMaster_0_avm_m0_readdata        ,
			AvalonSimpleMaster_0_avm_m0_write       => AvalonSimpleMaster_0_avm_m0_write           ,
			AvalonSimpleMaster_0_avm_m0_writedata   => AvalonSimpleMaster_0_avm_m0_writedata       ,
			AvalonSimpleMaster_0_reset_reset        => AvalonSimpleMaster_0_reset_reset            ,

			new_sdram_controller_0_wire_addr        =>	SDRAM_ADDR(11 downto 0)					,	--	: out   std_logic_vector(11 downto 0);                    -- new_sdram_controller_0_wire.addr
			new_sdram_controller_0_wire_ba          =>	new_sdram_controller_0_wire_ba   			,	--	: out   std_logic_vector(1 downto 0);                     --                            .ba
			new_sdram_controller_0_wire_cas_n       =>	SDRAM_CAS_N									,	--	: out   std_logic;                                        --                            .cas_n
			new_sdram_controller_0_wire_cke         =>	SDRAM_CKE  									,	--	: out   std_logic;                                        --                            .cke
			new_sdram_controller_0_wire_cs_n        =>	SDRAM_CS_N 									,	--	: out   std_logic;                                        --                            .cs_n
			new_sdram_controller_0_wire_dq          =>	SDRAM_DQ   									,	--	: inout std_logic_vector(15 downto 0) := (others => '0'); --                            .dq
			new_sdram_controller_0_wire_dqm         =>	new_sdram_controller_0_wire_dqm  			,	--	: out   std_logic_vector(1 downto 0);                     --                            .dqm
			new_sdram_controller_0_wire_ras_n       =>	SDRAM_RAS_N									,	--	: out   std_logic;                                        --                            .ras_n
			new_sdram_controller_0_wire_we_n        =>	SDRAM_WE_N 									,	--	: out   std_logic;                                        --                            .we_n
		
			clk_clk                                 => CLK,                                 --                         clk.clk
			clock_bridge_0_out_clk_clk              => SDRAM_CLK 								,	--   : out   std_logic                    ;
			reset_reset_n                           => RST_L                            --                       reset.reset_n
		);
	
	--SDRAM_CLK		<=	CLK		;
	
	SDRAM_UDQM	<=	new_sdram_controller_0_wire_dqm(1)	;
	SDRAM_LDQM	<=	new_sdram_controller_0_wire_dqm(0)	;
	
	SDRAM_BA_1	<=	new_sdram_controller_0_wire_ba(1)	;
	SDRAM_BA_0	<=	new_sdram_controller_0_wire_ba(0)	;
	
	SDRAM_ADDR(12)	<=	'0'		;
	
	
	process( CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wVGAFIFOWrData	<=	(others => '0')	;
			wVGAFIFOWrEn	<=	'0'	;
		elsif ( CLK'event and CLK = '1' ) then
			if(AvalonSimpleMaster_0_avm_m0_readdatavalid = '1')then
				wVGAFIFOWrData	<=	AvalonSimpleMaster_0_avm_m0_readdata	;
			end if;
			wVGAFIFOWrEn	<=	AvalonSimpleMaster_0_avm_m0_readdatavalid	;
		end if;
	end process;
	
	
	process( VIDEO_CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			wVGAFIFOClr	<=	'0'	;
			vsync_sig_DL1	<=	'0'	;
		elsif ( VIDEO_CLK'event and VIDEO_CLK = '1' ) then
			vsync_sig_DL1	<=	vsync_sig	;
			if(fRisEdge(vsync_sig, vsync_sig_DL1))then
				wVGAFIFOClr	<=	'1'	;
			else
				wVGAFIFOClr	<=	'0'	;
			end if;
		end if;
	end process;
	
	
	VGAFIFO_U	:	VGAFIFO
	PORT map
	(
		--aclr		=>	wVGAFIFOClr			,	--	: IN STD_LOGIC  := '0';
		aclr		=>	'0'			,	--	: IN STD_LOGIC  := '0';
		data		=>	wVGAFIFOWrData		,	--	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdclk		=>	VIDEO_CLK			,	--	: IN STD_LOGIC ;
		rdreq		=>	wVGAFIFORdEn		,	--	: IN STD_LOGIC ;
		wrclk		=>	CLK					,	--	: IN STD_LOGIC ;
		wrreq		=>	wVGAFIFOWrEn		,	--	: IN STD_LOGIC ;
		q			=>	wVGAFIFORdData		,	--	: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdempty		=>	open				,	--	: OUT STD_LOGIC ;
		rdusedw		=>	open				,	--	: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
		wrfull		=>	open				,	--	: OUT STD_LOGIC ;
		wrusedw		=>	wVGAwrusedw			--	: OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
	);
	
	wVGAFIFORdEn	<=	pixelena_bf1clk	;
	
	reset	<=	not RST_L	;		--????
	vga_syncgen_U : vga_syncgen
	generic map (
		H_TOTAL		=> 858,	-- 480p
		H_SYNC		=> 63,
		H_BACKP		=> 59,
		H_ACTIVE	=> 720,
		V_TOTAL		=> 525,
		V_SYNC		=> 6,
		V_BACKP		=> 30,
		V_ACTIVE	=> 480
		
		--H_TOTAL		=>	800,	-- VGA(640x480) / 25.175MHz
		--H_SYNC		=>	96,
		--H_BACKP		=>	48,
		--H_ACTIVE	=>	640,
		--V_TOTAL		=>	525,
		--V_SYNC		=>	2,
		--V_BACKP		=>	33,
		--V_ACTIVE	=>	480

	)
	port map (
		video_clk	=> VIDEO_CLK,
		reset		=> reset,
		scan_ena	=> '1',
		dither_ena	=> '0',
		test_hcount	=> open,
		test_vcount => test_vcount,
		framestart	=> open,
		linestart	=> open,
		line_reg_bf1cyc	=>	line_reg_bf1cyc	,
		line_reg_bf1cyc_10clk	=>	line_reg_bf1cyc_10clk	,
		dither		=> open,
		pixelena	=> pixelena,
		pixelena_bf1clk => pixelena_bf1clk,
		hsync		=> hsync_sig,
		vsync		=> vsync_sig,
		hblank		=> hblank,
		vblank		=> vblank
	);
	
	
	--iBLUE		<=	wVGAFIFORdData(4 downto 0) & "111"		;
	--iGREEN		<=	wVGAFIFORdData(10 downto 5) & "11"	;
	--iRED		<=	wVGAFIFORdData(15 downto 11) & "111"	;
	--iDE			<=	(not hblank) and (not vblank);
	--iHSYNC		<=	hsync_sig	;
	--iVSYNC		<=	vsync_sig	;
	
	process( VIDEO_CLK , RST_L )
	begin
		if ( RST_L = '0' ) then
			iBLUE		<=	(others => '0');
			iGREEN		<=	(others => '0');
			iRED		<=	(others => '0');
			iDE			<=	'0'	;
			iHSYNC		<=	'0'	;
			iVSYNC		<=	'0'	;
		elsif ( VIDEO_CLK'event and VIDEO_CLK = '1' ) then
			iBLUE		<=	wVGAFIFORdData(4 downto 0) & "111"		;
			iGREEN		<=	wVGAFIFORdData(10 downto 5) & "11"	;
			iRED		<=	wVGAFIFORdData(15 downto 11) & "111"	;
			iDE			<=	(not hblank) and (not vblank);
			iHSYNC		<=	hsync_sig	;
			iVSYNC		<=	vsync_sig	;
		end if;
	end process;
	
	
	end	arcFRAME_BUF;
