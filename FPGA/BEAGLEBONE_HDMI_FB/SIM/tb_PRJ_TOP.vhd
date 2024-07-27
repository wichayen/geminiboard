	library		ieee;
	use			ieee.std_logic_1164.all	;
	use			ieee.std_logic_unsigned.all;
	use			ieee.std_logic_arith.all;
	
	use			work.SIM_PKG.all;
	
	entity	tb_PRJ_TOP	is
	end	tb_PRJ_TOP;

	architecture	arctb_PRJ_TOP	of	tb_PRJ_TOP	is
----------------------------------------------------------
----Component
----------------------------------------------------------
	
	component PRJ_TOP is
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
	end component;
	
	Component mt48lc8m16a2 IS
    PORT (
        BA0             : IN    std_logic := 'U';
        BA1             : IN    std_logic := 'U';
        DQML            : IN    std_logic := 'U';
        DQMU            : IN    std_logic := 'U';
        DQ0             : INOUT std_logic := 'U';
        DQ1             : INOUT std_logic := 'U';
        DQ2             : INOUT std_logic := 'U';
        DQ3             : INOUT std_logic := 'U';
        DQ4             : INOUT std_logic := 'U';
        DQ5             : INOUT std_logic := 'U';
        DQ6             : INOUT std_logic := 'U';
        DQ7             : INOUT std_logic := 'U';
        DQ8             : INOUT std_logic := 'U';
        DQ9             : INOUT std_logic := 'U';
        DQ10            : INOUT std_logic := 'U';
        DQ11            : INOUT std_logic := 'U';
        DQ12            : INOUT std_logic := 'U';
        DQ13            : INOUT std_logic := 'U';
        DQ14            : INOUT std_logic := 'U';
        DQ15            : INOUT std_logic := 'U';
        CLK             : IN    std_logic := 'U';
        CKE             : IN    std_logic := 'U';
        A0              : IN    std_logic := 'U';
        A1              : IN    std_logic := 'U';
        A2              : IN    std_logic := 'U';
        A3              : IN    std_logic := 'U';
        A4              : IN    std_logic := 'U';
        A5              : IN    std_logic := 'U';
        A6              : IN    std_logic := 'U';
        A7              : IN    std_logic := 'U';
        A8              : IN    std_logic := 'U';
        A9              : IN    std_logic := 'U';
        A10             : IN    std_logic := 'U';
        A11             : IN    std_logic := 'U';
        WENeg           : IN    std_logic := 'U';
        RASNeg          : IN    std_logic := 'U';
        CSNeg           : IN    std_logic := 'U';
        CASNeg          : IN    std_logic := 'U'
    );
END Component;

----------------------------------------------------------
----Signal
----------------------------------------------------------
	-----------------------------------------------------------------------------------------
	--	-->> simulation parameter
	-----------------------------------------------------------------------------------------
	
	-----------------------------------------------------------------------------------------
	--	<<-- simulation parameter
	-----------------------------------------------------------------------------------------
	constant	kCLK_30M					:	time									:=33.33 ns;
	signal		iCLK_30M					:	std_logic								;
	
	signal		RST_L						:	std_logic;
	signal		clk_in					:	std_logic;		-- input clock
    
	signal		dvi_data0_p					: std_logic;		-- GPIO1_D16
	signal		dvi_data0_n					: std_logic;		-- GPIO1_D17
	signal		dvi_data1_p					: std_logic;		-- GPIO1_D20
	signal		dvi_data1_n					: std_logic;		-- GPIO1_D21
	signal		dvi_data2_p					: std_logic;		-- GPIO1_D13
	signal		dvi_data2_n					: std_logic;		-- GPIO1_D12
	signal		dvi_clock_p					: std_logic;		-- GPIO1_D9
	signal		dvi_clock_n					: std_logic;			-- GPIO1_D8
	
	signal		SDRAM_DQ					:	std_logic_vector(15 downto 0)	;
	signal		SDRAM_ADDR					:	std_logic_vector(12 downto 0)		;
	signal		SDRAM_LDQM					:	std_logic							;
	signal		SDRAM_UDQM					:	std_logic							;
	signal		SDRAM_WE_N					:	std_logic							;
	signal		SDRAM_CAS_N					:	std_logic							;
	signal		SDRAM_RAS_N					:	std_logic							;
	signal		SDRAM_CS_N					:	std_logic							;
	signal		SDRAM_BA_0					:	std_logic							;
	signal		SDRAM_BA_1					:	std_logic							;
	signal		SDRAM_CLK					:	std_logic							;
	signal		SDRAM_CKE					:	std_logic							;
	
	signal	FLASH_DATA					:	std_logic_vector(3 downto 0)  := (others => 'X'); -- conduit_dataout
	signal	FLASH_DCLK					:	std_logic;                                        -- conduit_dclk_out
	signal	FLASH_nCS					:	std_logic_vector(0 downto 0) ;                     -- conduit_ncs
		
	
	
	signal		UART_TXD					:	std_logic							;
	signal		UART_RXD					:	std_logic							;
	
	signal		LED							:	std_logic_vector(1 downto 0)		;
	
	signal		SW_TACT						:	std_logic_vector(1 downto 0)		;
	
	
	signal			wGPMC_BUS			:	tGPMC_BUS		:=	(	CS_L			=>	'1'						,	
																	WE_L			=>	'1'						,	
																	RD_L			=>	'1'						,	
																	ADV_L			=>	'1'						,	
																	AD				=>	(others => 'Z')			
													);
													
	signal			wReadData		:	std_logic_vector(15 downto 0)		;	--:=	(others => '0')	:
	signal			wWriteData		:	std_logic_vector(15 downto 0)		;	--:=	(others => '0')	:
	signal			wAddr			:	std_logic_vector(31 downto 0)		;	--:=	(others => '0')	:
----------------------------------------------------------
----Function
----------------------------------------------------------
	
----====================================================--
	begin
	
	process
	begin
		iCLK_30M <= '0';
		wait for kCLK_30M / 2 ;
		iCLK_30M <= '1';
		wait for kCLK_30M - ( kCLK_30M / 2 );
	end process;
	clk_in		<=	iCLK_30M	;
	
	
	SIM_PRJ_TOP		:	PRJ_TOP
		generic map(
	--		RESOLUTION		: string := "VGA"		-- 25.175MHz,640x480,60Hz,4:3
	--		RESOLUTION		: string := "SVGA"		-- 40.000MHz,800x600,60Hz,4:3
	--		RESOLUTION		: string := "XGA"		-- 65.000MHz,1024x768,60Hz,4:3
			RESOLUTION		=> "480p"		-- 27.000MHz,720x480,60Hz/59.94Hz,4:3/16:9
	--		RESOLUTION		=>	"720p"		-- 74.250MHz,1280x720,60Hz/59.94Hz,16:9
	--		RESOLUTION		: string := "1080p/30"	-- 74.250MHz,1920x1080,30Hz/29.97Hz,16:9
		)
		port map(
			clk_in					=>	clk_in				,	--		: in  std_logic;		-- input clock 30MHz
			
	--		test_hsync_n			=>	test_hsync_n		,	--		: out std_logic;		-- GPIO1_D31
	--		test_vsync_n			=>	test_vsync_n		,	--		: out std_logic;		-- GPIO1_D30
	--		test_enable				=>	test_enable			,	--		: out std_logic;		-- GPIO1_D29
	--		test_locked				=>	test_locked			,	--		: out std_logic;		-- LED[0]
			
			dvi_data0_p				=>	dvi_data0_p			,	--		: out std_logic;		-- GPIO1_D16
			dvi_data0_n				=>	dvi_data0_n			,	--		: out std_logic;		-- GPIO1_D17
			dvi_data1_p				=>	dvi_data1_p			,	--		: out std_logic;		-- GPIO1_D20
			dvi_data1_n				=>	dvi_data1_n			,	--		: out std_logic;		-- GPIO1_D21
			dvi_data2_p				=>	dvi_data2_p			,	--		: out std_logic;		-- GPIO1_D13
			dvi_data2_n				=>	dvi_data2_n			,	--		: out std_logic;		-- GPIO1_D12
			dvi_clock_p				=>	dvi_clock_p			,	--		: out std_logic;		-- GPIO1_D9
			dvi_clock_n				=>	dvi_clock_n			,	--		: out std_logic;			-- GPIO1_D8
			
			-- GPMC                 =>	-- GPMC         	,	--	
			AD						=>	wGPMC_BUS.AD				,	--		:	inout	std_logic_vector(15 downto 0)	;
			ADV_L					=>	wGPMC_BUS.ADV_L				,	--		:	in	std_logic							;
			WE_L					=>	wGPMC_BUS.WE_L				,	--		:	in	std_logic							;
			RD_L					=>	wGPMC_BUS.RD_L				,	--		:	in	std_logic							;	--OEN
			CS_L					=>	wGPMC_BUS.CS_L				,	--		:	in	std_logic							;
			
			-- SDRAM                =>	-- SDRAM        	,	--	
			SDRAM_DQ				=>	SDRAM_DQ			,	--		:	inout	std_logic_vector(15 downto 0)	;
			SDRAM_ADDR				=>	SDRAM_ADDR			,	--		:	out	std_logic_vector(12 downto 0)		;
			SDRAM_LDQM				=>	SDRAM_LDQM			,	--		:	out	std_logic							;
			SDRAM_UDQM				=>	SDRAM_UDQM			,	--		:	out	std_logic							;
			SDRAM_WE_N				=>	SDRAM_WE_N			,	--		:	out	std_logic							;
			SDRAM_CAS_N				=>	SDRAM_CAS_N			,	--		:	out	std_logic							;
			SDRAM_RAS_N				=>	SDRAM_RAS_N			,	--		:	out	std_logic							;
			SDRAM_CS_N				=>	SDRAM_CS_N			,	--		:	out	std_logic							;
			SDRAM_BA_0				=>	SDRAM_BA_0			,	--		:	out	std_logic							;
			SDRAM_BA_1				=>	SDRAM_BA_1			,	--		:	out	std_logic							;
			SDRAM_CLK				=>	SDRAM_CLK			,	--		:	out	std_logic							;
			SDRAM_CKE				=>	SDRAM_CKE			,	--		:	out	std_logic							;
			
			-- serial Flash         =>	-- serial Flash 	,	--	
			FLASH_DATA				=>	FLASH_DATA			,	--		:	inout std_logic_vector(3 downto 0)  := (others => 'X'); -- conduit_dataout
			FLASH_DCLK				=>	FLASH_DCLK			,	--		:	out   std_logic;                                        -- conduit_dclk_out
			FLASH_nCS				=>	FLASH_nCS			,	--		:	out   std_logic_vector(0 downto 0) ;                     -- conduit_ncs
			
			-- UART                 =>	-- UART         	,	--	
			UART_TXD				=>	UART_TXD			,	--		:	out	std_logic							;
			UART_RXD				=>	UART_RXD			,	--		:	in	std_logic							;
			
			LED						=>	LED					,	--		:	out	std_logic_vector(1 downto 0)		;
			
			SW_TACT					=>	SW_TACT					--		:	in	std_logic_vector(1 downto 0)		
			
			
		);
	
	
	mt48lc8m16a2_U	:	mt48lc8m16a2
    PORT map (
        BA0          =>	SDRAM_BA_0			,	--    : IN    std_logic := 'U';
        BA1          =>	SDRAM_BA_1			,	--    : IN    std_logic := 'U';
        DQML         =>	SDRAM_LDQM			,	--    : IN    std_logic := 'U';
        DQMU         =>	SDRAM_UDQM			,	--    : IN    std_logic := 'U';
        DQ0          =>	SDRAM_DQ(0)			,	--    : INOUT std_logic := 'U';
        DQ1          =>	SDRAM_DQ(1)			,	--    : INOUT std_logic := 'U';
        DQ2          =>	SDRAM_DQ(2)			,	--    : INOUT std_logic := 'U';
        DQ3          =>	SDRAM_DQ(3)			,	--    : INOUT std_logic := 'U';
        DQ4          =>	SDRAM_DQ(4)			,	--    : INOUT std_logic := 'U';
        DQ5          =>	SDRAM_DQ(5)			,	--    : INOUT std_logic := 'U';
        DQ6          =>	SDRAM_DQ(6)			,	--    : INOUT std_logic := 'U';
        DQ7          =>	SDRAM_DQ(7)			,	--    : INOUT std_logic := 'U';
        DQ8          =>	SDRAM_DQ(8)			,	--    : INOUT std_logic := 'U';
        DQ9          =>	SDRAM_DQ(9)			,	--    : INOUT std_logic := 'U';
        DQ10         =>	SDRAM_DQ(10)		,	--    : INOUT std_logic := 'U';
        DQ11         =>	SDRAM_DQ(11)		,	--    : INOUT std_logic := 'U';
        DQ12         =>	SDRAM_DQ(12)		,	--    : INOUT std_logic := 'U';
        DQ13         =>	SDRAM_DQ(13)		,	--    : INOUT std_logic := 'U';
        DQ14         =>	SDRAM_DQ(14)		,	--    : INOUT std_logic := 'U';
        DQ15         =>	SDRAM_DQ(15)		,	--    : INOUT std_logic := 'U';
        CLK          =>	SDRAM_CLK			,	--    : IN    std_logic := 'U';
        CKE          =>	SDRAM_CKE			,	--    : IN    std_logic := 'U';
        A0           =>	SDRAM_ADDR(0)		,	--    : IN    std_logic := 'U';
        A1           =>	SDRAM_ADDR(1)		,	--    : IN    std_logic := 'U';
        A2           =>	SDRAM_ADDR(2)		,	--    : IN    std_logic := 'U';
        A3           =>	SDRAM_ADDR(3)		,	--    : IN    std_logic := 'U';
        A4           =>	SDRAM_ADDR(4)		,	--    : IN    std_logic := 'U';
        A5           =>	SDRAM_ADDR(5)		,	--    : IN    std_logic := 'U';
        A6           =>	SDRAM_ADDR(6)		,	--    : IN    std_logic := 'U';
        A7           =>	SDRAM_ADDR(7)		,	--    : IN    std_logic := 'U';
        A8           =>	SDRAM_ADDR(8)		,	--    : IN    std_logic := 'U';
        A9           =>	SDRAM_ADDR(9)		,	--    : IN    std_logic := 'U';
        A10          =>	SDRAM_ADDR(10)		,	--    : IN    std_logic := 'U';
        A11          =>	SDRAM_ADDR(11)		,	--    : IN    std_logic := 'U';
        WENeg        =>	SDRAM_WE_N			,	--    : IN    std_logic := 'U';
        RASNeg       =>	SDRAM_RAS_N			,	--    : IN    std_logic := 'U';
        CSNeg        =>	SDRAM_CS_N			,	--    : IN    std_logic := 'U';
        CASNeg       =>	SDRAM_CAS_N				--    : IN    std_logic := 'U'
		);
		
	
	process
		
	begin
		RST_L		<=	'0'		;
		SW_TACT(0)	<=	'0'		;
		wait for kCLK_30M * 5 ;
		wait until iCLK_30M'event and iCLK_30M = '0';
		RST_L <= '1';
		SW_TACT(0)	<=	'1'		;
		
		--wait for 1ms;
		wait for 120us;
		wait until iCLK_30M'event and iCLK_30M = '0';
		
		
		wWriteData	<=	x"0000"	;
		for i in 0 to 1000 loop
			GPMC_Wr(x"0000_0000", wWriteData, iCLK_30M, wGPMC_BUS, 1)	;
			wWriteData	<=	wWriteData + 1;
		end loop;
		
		
		--GPMC_Wr(x"0000_F000", x"0001", iCLK_30M, wGPMC_BUS, 1)	;
		for i in 0 to 350000 loop
			GPMC_Wr(x"0000_0000", wWriteData, iCLK_30M, wGPMC_BUS, 1)	;
			wWriteData	<=	wWriteData + 1;
		end loop;
		
		wait;
		
		
	end process;
	
	
	
	end	arctb_PRJ_TOP;
	
	