----------------------------------------------------------------------
-- TITLE : Pseudo-differential transmitter
--
--     VERFASSER : S.OSAFUNE (J-7SYSTEM Works)
--     DATUM     : 2005/10/13 -> 2005/10/13 (HERSTELLUNG)
--
--               : 2013/01/30 �^�������쓮�ɕύX 
--               : 2013/02/02 �V���A���C�U���C�� 
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity pdiff_transmitter is
	generic(
		RESET_LEVEL		: std_logic := '1';	-- Positive logic reset
--		RESOLUTION		: string := "VGA"	-- 25.175MHz
--		RESOLUTION		: string := "SVGA"	-- 40.000MHz
--		RESOLUTION		: string := "XGA"	-- 65.000MHz
		RESOLUTION		: string := "480p"	-- 27.000MHz
--		RESOLUTION		: string := "720p"	-- 74.250MHz
--		RESOLUTION		: string := "1080p/30"	-- 74.250MHz
	);
	port(
		reset		: in  std_logic;
		clk			: in  std_logic;
		clk_dot_sig	: in  std_logic;
		clk_ser_sig	: in  std_logic;
		reset_n_sig	: in  std_logic;
		pll_locked	: out std_logic;

		data0_in	: in  std_logic_vector(9 downto 0);
		data1_in	: in  std_logic_vector(9 downto 0);
		data2_in	: in  std_logic_vector(9 downto 0);

		tx0_out_p	: out std_logic;
		tx0_out_n	: out std_logic;
		tx1_out_p	: out std_logic;
		tx1_out_n	: out std_logic;
		tx2_out_p	: out std_logic;
		tx2_out_n	: out std_logic;
		txc_out_p	: out std_logic;
		txc_out_n	: out std_logic
	);
end pdiff_transmitter;

architecture RTL of pdiff_transmitter is
	signal areset_sig	: std_logic;

	signal data0_in_reg	: std_logic_vector(9 downto 0);
	signal data1_in_reg	: std_logic_vector(9 downto 0);
	signal data2_in_reg	: std_logic_vector(9 downto 0);

	signal start_reg	: std_logic_vector(4 downto 0);

	signal data0_ser_reg: std_logic_vector(9 downto 0);
	signal data0p_h_reg	: std_logic;
	signal data0p_l_reg	: std_logic;
	signal data0n_h_reg	: std_logic;
	signal data0n_l_reg	: std_logic;

	signal data1_ser_reg: std_logic_vector(9 downto 0);
	signal data1p_h_reg	: std_logic;
	signal data1p_l_reg	: std_logic;
	signal data1n_h_reg	: std_logic;
	signal data1n_l_reg	: std_logic;

	signal data2_ser_reg: std_logic_vector(9 downto 0);
	signal data2p_h_reg	: std_logic;
	signal data2p_l_reg	: std_logic;
	signal data2n_h_reg	: std_logic;
	signal data2n_l_reg	: std_logic;

	signal clock_ser_reg: std_logic_vector(9 downto 0);
	signal clockp_h_reg	: std_logic;
	signal clockp_l_reg	: std_logic;
	signal clockn_h_reg	: std_logic;
	signal clockn_l_reg	: std_logic;


	-- �V���A���C�UPLL --
--	signal clk_dot_sig	: std_logic;
--	signal clk_ser_sig	: std_logic;
--	signal reset_n_sig	: std_logic := '0';
	
	
	signal	data0p_reg	:	std_logic_vector(1 downto 0)	;
	signal	data0n_reg	:	std_logic_vector(1 downto 0)	;
	signal	data1p_reg	:	std_logic_vector(1 downto 0)	;
	signal	data1n_reg	:	std_logic_vector(1 downto 0)	;
	signal	data2p_reg	:	std_logic_vector(1 downto 0)	;
	signal	data2n_reg	:	std_logic_vector(1 downto 0)	;
	signal	clockp_reg	:	std_logic_vector(1 downto 0)	;
	signal	clockn_reg	:	std_logic_vector(1 downto 0)	;
	
	
	signal	tx0_out_p_std	:	std_logic_vector(0 downto 0)	;
	signal	tx0_out_n_std	:	std_logic_vector(0 downto 0)	;
	signal	tx1_out_p_std	:	std_logic_vector(0 downto 0)	;
	signal	tx1_out_n_std	:	std_logic_vector(0 downto 0)	;
	signal	tx2_out_p_std	:	std_logic_vector(0 downto 0)	;
	signal	tx2_out_n_std	:	std_logic_vector(0 downto 0)	;
	signal	txc_out_p_std	:	std_logic_vector(0 downto 0)	;
	signal	txc_out_n_std	:	std_logic_vector(0 downto 0)	;
	


	-- DDR I/O�o�� --
	component ddio_out
	port
	(
		outclock : in  std_logic                    := '0';             -- outclock.export
		din      : in  std_logic_vector(1 downto 0) := (others => '0'); --      din.export
		pad_out  : out std_logic_vector(0 downto 0)                     --  pad_out.export
	);
	end component;

begin

	-- �N���b�N�����Z�b�g���� --

	areset_sig <= '1' when(reset = RESET_LEVEL) else '0';
	pll_locked <= reset_n_sig;




	-- ���N���b�N�ւ̍ڂ��ւ� --

	process (clk_dot_sig) begin
		if (clk_dot_sig'event and clk_dot_sig='1') then
			data0_in_reg <= data0_in;
			data1_in_reg <= data1_in;
			data2_in_reg <= data2_in;
		end if;
	end process;


	-- ���b�`�M���̐����ƃV�t�g���W�X�^ --

	process (clk_ser_sig, reset_n_sig) begin
		if (reset_n_sig = '0') then
			start_reg <= "00001";

		elsif (clk_ser_sig'event and clk_ser_sig='1') then
			start_reg <= start_reg(0) & start_reg(4 downto 1);

			if (start_reg(0) = '1') then
				data0_ser_reg <= data0_in_reg;
				data1_ser_reg <= data1_in_reg;
				data2_ser_reg <= data2_in_reg;
				clock_ser_reg <= "0000011111";
			else
				data0_ser_reg <= "XX" & data0_ser_reg(9 downto 2);
				data1_ser_reg <= "XX" & data1_ser_reg(9 downto 2);
				data2_ser_reg <= "XX" & data2_ser_reg(9 downto 2);
				clock_ser_reg <= "XX" & clock_ser_reg(9 downto 2);
			end if;
		end if;
	end process;


	-- �r�b�g�o�� --

	process (clk_ser_sig) begin
		if (clk_ser_sig'event and clk_ser_sig='1') then
			data0p_h_reg <= data0_ser_reg(0);
			data0p_l_reg <= data0_ser_reg(1);
			data0n_h_reg <= not data0_ser_reg(0);
			data0n_l_reg <= not data0_ser_reg(1);

			data1p_h_reg <= data1_ser_reg(0);
			data1p_l_reg <= data1_ser_reg(1);
			data1n_h_reg <= not data1_ser_reg(0);
			data1n_l_reg <= not data1_ser_reg(1);

			data2p_h_reg <= data2_ser_reg(0);
			data2p_l_reg <= data2_ser_reg(1);
			data2n_h_reg <= not data2_ser_reg(0);
			data2n_l_reg <= not data2_ser_reg(1);

			clockp_h_reg <= clock_ser_reg(0);
			clockp_l_reg <= clock_ser_reg(1);
			clockn_h_reg <= not clock_ser_reg(0);
			clockn_l_reg <= not clock_ser_reg(1);
		end if;
	end process;
	
	data0p_reg	<=	data0p_l_reg & data0p_h_reg ;
	data0n_reg	<=	data0n_l_reg & data0n_h_reg ;
	data1p_reg	<=	data1p_l_reg & data1p_h_reg ;
	data1n_reg	<=	data1n_l_reg & data1n_h_reg ;
	data2p_reg	<=	data2p_l_reg & data2p_h_reg ;
	data2n_reg	<=	data2n_l_reg & data2n_h_reg ;
	clockp_reg	<=	clockp_l_reg & clockp_h_reg ;
	clockn_reg	<=	clockn_l_reg & clockn_h_reg ;

	
	
	TX0_P : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	data0p_reg		,
			pad_out 	=>	tx0_out_p_std	
		);
		
	TX0_N : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	data0n_reg		,
			pad_out 	=>	tx0_out_n_std	
		);

	TX1_P : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	data1p_reg		,
			pad_out 	=>	tx1_out_p_std	
		);
	TX1_N : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	data1n_reg		,
			pad_out 	=>	tx1_out_n_std	
		);

	TX2_P : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	data2p_reg		,
			pad_out 	=>	tx2_out_p_std	
		);
	TX2_N : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	data2n_reg		,
			pad_out 	=>	tx2_out_n_std	
		);

	TXC_P : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	clockp_reg		,
			pad_out 	=>	txc_out_p_std	
		);
	TXC_N : ddio_out
		port map (
			outclock	=>	clk_ser_sig		,
			din     	=>	clockn_reg		,
			pad_out 	=>	txc_out_n_std	
		);
	
	
	tx0_out_p	<=	tx0_out_p_std(0)	;
	tx0_out_n	<=	tx0_out_n_std(0)	;
	tx1_out_p	<=	tx1_out_p_std(0)	;
	tx1_out_n	<=	tx1_out_n_std(0)	;
	tx2_out_p	<=	tx2_out_p_std(0)	;
	tx2_out_n	<=	tx2_out_n_std(0)	;
	txc_out_p	<=	txc_out_p_std(0)	;
	txc_out_n	<=	txc_out_n_std(0)	;
	
	
	

end RTL;



----------------------------------------------------------------------
--   Copyright (C)2010-2013 J-7SYSTEM Works.  All rights Reserved.  --
----------------------------------------------------------------------
