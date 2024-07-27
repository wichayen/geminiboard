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
		
		-- Digital IO
		--DIGITAL_IO					:	inout	std_logic_vector(27 downto 0)		;
		
		-- SDRAM
		SDRAM_DQ					:	inout	std_logic_vector(15 downto 0)	;
		SDRAM_ADDR					:	out	std_logic_vector(11 downto 0)		;
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

--	signal hsync_sig		: std_logic;
--	signal vsync_sig		: std_logic;
--	signal hblank_sig		: std_logic;
--	signal vblank_sig		: std_logic;
--	signal de_sig			: std_logic;
--	signal hcount_sig		: std_logic_vector(10 downto 0);
--	signal vcount_sig		: std_logic_vector(9 downto 0);
--
--	signal pix_r_sig		: std_logic_vector(7 downto 0);
--	signal pix_g_sig		: std_logic_vector(7 downto 0);
--	signal pix_b_sig		: std_logic_vector(7 downto 0);

	signal	clk_dot_sig		:	std_logic	;
	signal	clk_ser_sig		:	std_logic	;
	signal	clk_qsys		:	std_logic	;
	signal	clk_qspi		:	std_logic	;
	
	signal	areset			:	std_logic	;
	signal	reset			:	std_logic	;
	
	signal	wLED0			:	std_logic	;
	signal	wCnt0			:	integer range 0 to 1000000000;
	
	signal	wLED1			:	std_logic	;
	signal	wCnt1			:	integer range 0 to 1000000000;
	
	
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
	
	
	component NIOS_CPU is
		port (
			clk_clk                                                       : in    std_logic                     := 'X';             -- clk
			clock_bridge_0_in_clk_clk                                     : in    std_logic                     := 'X';             -- clk
--			new_sdram_controller_0_wire_addr                              : out   std_logic_vector(11 downto 0);                    -- addr
--			new_sdram_controller_0_wire_ba                                : out   std_logic_vector(1 downto 0);                     -- ba
--			new_sdram_controller_0_wire_cas_n                             : out   std_logic;                                        -- cas_n
--			new_sdram_controller_0_wire_cke                               : out   std_logic;                                        -- cke
--			new_sdram_controller_0_wire_cs_n                              : out   std_logic;                                        -- cs_n
--			new_sdram_controller_0_wire_dq                                : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
--			new_sdram_controller_0_wire_dqm                               : out   std_logic_vector(1 downto 0);                     -- dqm
--			new_sdram_controller_0_wire_ras_n                             : out   std_logic;                                        -- ras_n
--			new_sdram_controller_0_wire_we_n                              : out   std_logic;                                        -- we_n
			generic_quad_spi_controller_0_flash_dataout_conduit_dataout   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- conduit_dataout
			generic_quad_spi_controller_0_flash_dclk_out_conduit_dclk_out : out   std_logic;                                        -- conduit_dclk_out
			generic_quad_spi_controller_0_flash_ncs_conduit_ncs           : out   std_logic_vector(0 downto 0);                     -- conduit_ncs
			uart_0_external_connection_rxd                                : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd                                : out   std_logic                            ;            -- txd
			pio_0_external_connection_export                              : out   std_logic_vector(27 downto 0)        ;             -- export
			reset_reset_n                                                 : in    std_logic                     := 'X'             -- reset_n
		);
	end component NIOS_CPU;

	
		
	signal		wSDRAM_BA			:	std_logic_vector(1 downto 0)		;
	signal		wSDRAM_DQM			:	std_logic_vector(1 downto 0)		;
	signal		wSW_TACT0			:	std_logic								;
	signal		reset_n				:	std_logic								;
	
	
begin

--	test_hsync_n <= not hsync_sig;
--	test_vsync_n <= not vsync_sig;
--	test_enable  <= de_sig;
--	test_locked  <= locked_sig;
--	
	process (clk_in) begin
		if(clk_in'event and clk_in='1') then
			wSW_TACT0	<=	SW_TACT(0)	;
			reset_n		<=	wSW_TACT0	;
			areset		<=	not reset_n	;
		end if;
	end process;
----	
--	wSW_TACT0	<=	SW_TACT(0)	;
--	reset_n		<=	wSW_TACT0	;
--	areset		<=	not reset_n	;
--	reset		<=	not reset_n_sig	;
	
	pll_inst : pll_video_sd PORT MAP (
		areset		=>	areset			,	--	: IN STD_LOGIC  := '0';
		inclk0		=>	clk_in			,	--	: IN STD_LOGIC  := '0';
		c0			=>	videoclk_sig		,	--	: OUT STD_LOGIC ;	--27MHz
		c1			=>	clk_dot_sig			,	--	: OUT STD_LOGIC ;	--27MHz
		c2			=>	clk_ser_sig			,	--	: OUT STD_LOGIC ;	--135MHz
		c3			=>	clk_qsys			,	--	: OUT STD_LOGIC ;
		c4			=>	clk_qspi			,
		locked		=>	reset_n_sig				--	: OUT STD_LOGIC 
	);

	dvi_data0_p		<=	'Z'	;	--: out std_logic;		-- GPIO1_D16
	dvi_data0_n		<=	'Z'	;	--: out std_logic;		-- GPIO1_D17
	dvi_data1_p		<=	'Z'	;	--: out std_logic;		-- GPIO1_D20
	dvi_data1_n		<=	'Z'	;	--: out std_logic;		-- GPIO1_D21
	dvi_data2_p		<=	'Z'	;	--: out std_logic;		-- GPIO1_D13
	dvi_data2_n		<=	'Z'	;	--: out std_logic;		-- GPIO1_D12
	dvi_clock_p		<=	'Z'	;	--: out std_logic;		-- GPIO1_D9
	dvi_clock_n		<=	'Z'	;	--: out std_logic;			-- GPIO1_D8
	
	
	u0 : component NIOS_CPU
		port map (
			clk_clk                           => clk_qsys				,                           --                         clk.clk
			clock_bridge_0_in_clk_clk         => clk_qspi					,	--                            : in    std_logic                    := 'X'              -- clk
--			new_sdram_controller_0_wire_addr  => SDRAM_ADDR  		,	-- new_sdram_controller_0_wire.addr
--			new_sdram_controller_0_wire_ba    => wSDRAM_BA    		,	--                            .ba
--			new_sdram_controller_0_wire_cas_n => SDRAM_CAS_N 		,	--                            .cas_n
--			new_sdram_controller_0_wire_cke   => SDRAM_CKE   		,	--                            .cke
--			new_sdram_controller_0_wire_cs_n  => SDRAM_CS_N  		,	--                            .cs_n
--			new_sdram_controller_0_wire_dq    => SDRAM_DQ    		,	--                            .dq
--			new_sdram_controller_0_wire_dqm   => wSDRAM_DQM   		,	--                            .dqm
--			new_sdram_controller_0_wire_ras_n => SDRAM_RAS_N 		,	--                            .ras_n
--			new_sdram_controller_0_wire_we_n  => SDRAM_WE_N  		,	--                            .we_n
			generic_quad_spi_controller_0_flash_dataout_conduit_dataout    =>	FLASH_DATA			,	--	: inout std_logic_vector(3 downto 0)  := (others => 'X'); -- conduit_dataout
			generic_quad_spi_controller_0_flash_dclk_out_conduit_dclk_out  =>	FLASH_DCLK			,	--	: out   std_logic;                                        -- conduit_dclk_out
			generic_quad_spi_controller_0_flash_ncs_conduit_ncs            =>	FLASH_nCS			,	--	: out   std_logic_vector(0 downto 0)                      -- conduit_ncs
			uart_0_external_connection_rxd                               =>	UART_RXD			,	--	 : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd                               =>	UART_TXD			,	--	 : out   std_logic                                         -- txd
			pio_0_external_connection_export                             =>	open		,	-- : out   std_logic_vector(27 downto 0)                     -- export
			--reset_reset_n                      =>	reset_n                     					--	      : in    std_logic                     := 'X';             -- reset_n
			reset_reset_n                      =>	reset_n_sig                     					--	      : in    std_logic                     := 'X';             -- reset_n
		);
	
	
		
	----.zs_ba_from_the_sdram_0({DRAM_BA_1,DRAM_BA_0}),
	SDRAM_BA_1		<=	wSDRAM_BA(1)		;
	SDRAM_BA_0		<=	wSDRAM_BA(0)		;
	----.zs_dqm_from_the_sdram_0({DRAM_UDQM,DRAM_LDQM}),
	SDRAM_UDQM		<=	wSDRAM_DQM(1)		;
	SDRAM_LDQM		<=	wSDRAM_DQM(0)		;
	SDRAM_CLK		<=	clk_qsys					;
		
	
	
	--DIGITAL_IO		<=	(others => 'Z')	;
	
	-- UART
	--UART_TXD		<= UART_RXD		;
	
	
	--LED(0)		<=	not SW_TACT(0)	;
	LED(0)		<=	wLED0	;
	--LED(1)		<=	not SW_TACT(1)	;
	LED(1)		<=	wLED1		;
	
	process( clk_qsys , areset )
	begin
		if ( areset = '1' ) then
			wCnt0	<=	0		;
			wLED0	<=	'0'		;
		elsif ( clk_qsys'event and clk_qsys = '1' ) then
			if(wCnt0 /= 45000000)then
				wCnt0	<=	wCnt0 + 1;
			else
				wCnt0	<=	0	;
			end if;
			if(wCnt0 = 45000000)then
				wLED0	<=	not wLED0	;
			end if;
		end if;
	end process;
	
	
	process( clk_qspi , areset )
	begin
		if ( areset = '1' ) then
			wCnt1	<=	0		;
			wLED1	<=	'0'		;
		elsif ( clk_qspi'event and clk_qspi = '1' ) then
			if(wCnt1 /= 25000000)then
				wCnt1	<=	wCnt1 + 1;
			else
				wCnt1	<=	0	;
			end if;
			if(wCnt1 = 25000000)then
				wLED1	<=	not wLED1	;
			end if;
		end if;
	end process;
	
	
	
end RTL;



----------------------------------------------------------------------
--   Copyright (C)2010-2013 J-7SYSTEM Works.  All rights Reserved.  --
----------------------------------------------------------------------

