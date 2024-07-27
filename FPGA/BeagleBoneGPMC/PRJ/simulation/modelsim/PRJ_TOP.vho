-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 15.1.0 Build 185 10/21/2015 SJ Lite Edition"

-- DATE "01/12/2016 09:57:22"

-- 
-- Device: Altera 10M04SCE144C8G Package EQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	PRJ_TOP IS
    PORT (
	clk_in : IN std_logic;
	AD : INOUT std_logic_vector(15 DOWNTO 8);
	ADV_L : IN std_logic;
	WE_L : IN std_logic;
	RD_L : IN std_logic;
	LED : OUT std_logic_vector(1 DOWNTO 0);
	SW_TACT : IN std_logic_vector(1 DOWNTO 0)
	);
END PRJ_TOP;

-- Design Ports Information
-- LED[0]	=>  Location: PIN_124,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LED[1]	=>  Location: PIN_127,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- SW_TACT[0]	=>  Location: PIN_130,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW_TACT[1]	=>  Location: PIN_123,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- AD[8]	=>  Location: PIN_97,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- AD[9]	=>  Location: PIN_120,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- AD[10]	=>  Location: PIN_112,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- AD[11]	=>  Location: PIN_131,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- AD[12]	=>  Location: PIN_113,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- AD[13]	=>  Location: PIN_114,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- AD[14]	=>  Location: PIN_99,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- AD[15]	=>  Location: PIN_101,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- clk_in	=>  Location: PIN_90,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- WE_L	=>  Location: PIN_14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- RD_L	=>  Location: PIN_12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- ADV_L	=>  Location: PIN_11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF PRJ_TOP IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk_in : std_logic;
SIGNAL ww_ADV_L : std_logic;
SIGNAL ww_WE_L : std_logic;
SIGNAL ww_RD_L : std_logic;
SIGNAL ww_LED : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_SW_TACT : std_logic_vector(1 DOWNTO 0);
SIGNAL \U_PLL|altpll_component|auto_generated|pll1_INCLK_bus\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \U_PLL|altpll_component|auto_generated|pll1_CLK_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk_in~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \SW_TACT[0]~input_o\ : std_logic;
SIGNAL \SW_TACT[1]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \clk_in~input_o\ : std_logic;
SIGNAL \clk_in~inputclkctrl_outclk\ : std_logic;
SIGNAL \U_PLL|altpll_component|auto_generated|wire_pll1_fbout\ : std_logic;
SIGNAL \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\ : std_logic;
SIGNAL \AD[8]~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wAD[8]~feeder_combout\ : std_logic;
SIGNAL \U_PLL|altpll_component|auto_generated|wire_pll1_locked\ : std_logic;
SIGNAL \syn_reset_n~q\ : std_logic;
SIGNAL \U_GPMC_IF|iDataWr[8]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wCS_L~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wCS_L~q\ : std_logic;
SIGNAL \RD_L~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wOE_L~0_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wOE_L~q\ : std_logic;
SIGNAL \WE_L~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wWE_L~0_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wWE_L~q\ : std_logic;
SIGNAL \U_GPMC_IF|wWE_L_DL1~q\ : std_logic;
SIGNAL \U_GPMC_IF|iDataWr[8]~0_combout\ : std_logic;
SIGNAL \AD[14]~input_o\ : std_logic;
SIGNAL \ADV_L~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wADV_L~0_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wADV_L~q\ : std_logic;
SIGNAL \U_GPMC_IF|wADV_L_DL1~q\ : std_logic;
SIGNAL \U_GPMC_IF|process_2~0_combout\ : std_logic;
SIGNAL \AD[15]~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wAD[15]~feeder_combout\ : std_logic;
SIGNAL \AD[12]~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wAD[12]~feeder_combout\ : std_logic;
SIGNAL \AD[13]~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wAD[13]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wAddr[13]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|Mux7~0_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wpWE~0_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wpWE~1_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wpWE~q\ : std_logic;
SIGNAL \AD[11]~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wAD[11]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wAddr[11]~feeder_combout\ : std_logic;
SIGNAL \AD[9]~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wAD[9]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wAddr[9]~feeder_combout\ : std_logic;
SIGNAL \AD[10]~input_o\ : std_logic;
SIGNAL \U_GPMC_IF|wAD[10]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|Mux7~1_combout\ : std_logic;
SIGNAL \U_TEST_IP|wLED[8]~0_combout\ : std_logic;
SIGNAL \U_TEST_IP|iDataRd[8]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wOE_L_DL1~q\ : std_logic;
SIGNAL \U_GPMC_IF|wpRD~0_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wpRD~1_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wpRD~q\ : std_logic;
SIGNAL \U_TEST_IP|iDataRd[8]~0_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wDataRd[8]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wGate~combout\ : std_logic;
SIGNAL \U_GPMC_IF|iDataWr[9]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|wLED[9]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wDataRd[9]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|wLED[10]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wDataRd[10]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|iDataWr[11]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|wLED[11]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|iDataRd[11]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|iDataWr[12]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|wLED[12]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|wLED[13]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|iDataRd[13]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|wDataRd[13]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|iDataWr[14]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|iDataRd[14]~feeder_combout\ : std_logic;
SIGNAL \U_GPMC_IF|iDataWr[15]~feeder_combout\ : std_logic;
SIGNAL \U_TEST_IP|wLED[15]~feeder_combout\ : std_logic;
SIGNAL \U_PLL|altpll_component|auto_generated|wire_pll1_clk\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \U_TEST_IP|wLED\ : std_logic_vector(15 DOWNTO 8);
SIGNAL \U_GPMC_IF|iDataWr\ : std_logic_vector(15 DOWNTO 8);
SIGNAL \U_GPMC_IF|wAddr\ : std_logic_vector(15 DOWNTO 8);
SIGNAL \U_GPMC_IF|wAD\ : std_logic_vector(15 DOWNTO 8);
SIGNAL \U_GPMC_IF|wDataRd\ : std_logic_vector(15 DOWNTO 8);
SIGNAL \U_TEST_IP|iDataRd\ : std_logic_vector(15 DOWNTO 8);
SIGNAL \U_TEST_IP|ALT_INV_wLED\ : std_logic_vector(9 DOWNTO 8);

BEGIN

ww_clk_in <= clk_in;
ww_ADV_L <= ADV_L;
ww_WE_L <= WE_L;
ww_RD_L <= RD_L;
LED <= ww_LED;
ww_SW_TACT <= SW_TACT;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\U_PLL|altpll_component|auto_generated|pll1_INCLK_bus\ <= (gnd & \clk_in~inputclkctrl_outclk\);

\U_PLL|altpll_component|auto_generated|wire_pll1_clk\(0) <= \U_PLL|altpll_component|auto_generated|pll1_CLK_bus\(0);
\U_PLL|altpll_component|auto_generated|wire_pll1_clk\(1) <= \U_PLL|altpll_component|auto_generated|pll1_CLK_bus\(1);
\U_PLL|altpll_component|auto_generated|wire_pll1_clk\(2) <= \U_PLL|altpll_component|auto_generated|pll1_CLK_bus\(2);
\U_PLL|altpll_component|auto_generated|wire_pll1_clk\(3) <= \U_PLL|altpll_component|auto_generated|pll1_CLK_bus\(3);
\U_PLL|altpll_component|auto_generated|wire_pll1_clk\(4) <= \U_PLL|altpll_component|auto_generated|pll1_CLK_bus\(4);

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \U_PLL|altpll_component|auto_generated|wire_pll1_clk\(0));

\clk_in~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk_in~input_o\);
\U_TEST_IP|ALT_INV_wLED\(9) <= NOT \U_TEST_IP|wLED\(9);
\U_TEST_IP|ALT_INV_wLED\(8) <= NOT \U_TEST_IP|wLED\(8);

-- Location: LCCOMB_X11_Y22_N16
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X11_Y25_N16
\LED[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_TEST_IP|ALT_INV_wLED\(8),
	devoe => ww_devoe,
	o => ww_LED(0));

-- Location: IOOBUF_X11_Y25_N23
\LED[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_TEST_IP|ALT_INV_wLED\(9),
	devoe => ww_devoe,
	o => ww_LED(1));

-- Location: IOOBUF_X31_Y17_N9
\AD[8]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(8),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(8));

-- Location: IOOBUF_X15_Y25_N16
\AD[9]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(9),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(9));

-- Location: IOOBUF_X27_Y25_N16
\AD[10]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(10),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(10));

-- Location: IOOBUF_X6_Y10_N2
\AD[11]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(11),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(11));

-- Location: IOOBUF_X27_Y25_N30
\AD[12]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(12),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(12));

-- Location: IOOBUF_X24_Y25_N16
\AD[13]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(13),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(13));

-- Location: IOOBUF_X31_Y19_N23
\AD[14]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(14),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(14));

-- Location: IOOBUF_X31_Y19_N16
\AD[15]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U_GPMC_IF|wDataRd\(15),
	oe => \U_GPMC_IF|wGate~combout\,
	devoe => ww_devoe,
	o => AD(15));

-- Location: IOIBUF_X31_Y11_N22
\clk_in~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_in,
	o => \clk_in~input_o\);

-- Location: CLKCTRL_G9
\clk_in~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk_in~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk_in~inputclkctrl_outclk\);

-- Location: PLL_1
\U_PLL|altpll_component|auto_generated|pll1\ : fiftyfivenm_pll
-- pragma translate_off
GENERIC MAP (
	auto_settings => "false",
	bandwidth_type => "medium",
	c0_high => 10,
	c0_initial => 1,
	c0_low => 10,
	c0_mode => "even",
	c0_ph => 0,
	c1_high => 0,
	c1_initial => 0,
	c1_low => 0,
	c1_mode => "bypass",
	c1_ph => 0,
	c1_use_casc_in => "off",
	c2_high => 0,
	c2_initial => 0,
	c2_low => 0,
	c2_mode => "bypass",
	c2_ph => 0,
	c2_use_casc_in => "off",
	c3_high => 0,
	c3_initial => 0,
	c3_low => 0,
	c3_mode => "bypass",
	c3_ph => 0,
	c3_use_casc_in => "off",
	c4_high => 0,
	c4_initial => 0,
	c4_low => 0,
	c4_mode => "bypass",
	c4_ph => 0,
	c4_use_casc_in => "off",
	charge_pump_current_bits => 1,
	clk0_counter => "c0",
	clk0_divide_by => 1,
	clk0_duty_cycle => 50,
	clk0_multiply_by => 1,
	clk0_phase_shift => "0",
	clk1_counter => "unused",
	clk1_divide_by => 0,
	clk1_duty_cycle => 50,
	clk1_multiply_by => 0,
	clk1_phase_shift => "0",
	clk2_counter => "unused",
	clk2_divide_by => 0,
	clk2_duty_cycle => 50,
	clk2_multiply_by => 0,
	clk2_phase_shift => "0",
	clk3_counter => "unused",
	clk3_divide_by => 0,
	clk3_duty_cycle => 50,
	clk3_multiply_by => 0,
	clk3_phase_shift => "0",
	clk4_counter => "unused",
	clk4_divide_by => 0,
	clk4_duty_cycle => 50,
	clk4_multiply_by => 0,
	clk4_phase_shift => "0",
	compensate_clock => "clock0",
	inclk0_input_frequency => 33333,
	inclk1_input_frequency => 0,
	loop_filter_c_bits => 0,
	loop_filter_r_bits => 24,
	m => 20,
	m_initial => 1,
	m_ph => 0,
	n => 1,
	operation_mode => "normal",
	pfd_max => 200000,
	pfd_min => 3076,
	self_reset_on_loss_lock => "off",
	simulation_type => "functional",
	switch_over_type => "auto",
	vco_center => 1538,
	vco_divide_by => 0,
	vco_frequency_control => "auto",
	vco_max => 3333,
	vco_min => 1538,
	vco_multiply_by => 0,
	vco_phase_shift_step => 208,
	vco_post_scale => 2)
-- pragma translate_on
PORT MAP (
	areset => GND,
	fbin => \U_PLL|altpll_component|auto_generated|wire_pll1_fbout\,
	inclk => \U_PLL|altpll_component|auto_generated|pll1_INCLK_bus\,
	locked => \U_PLL|altpll_component|auto_generated|wire_pll1_locked\,
	fbout => \U_PLL|altpll_component|auto_generated|wire_pll1_fbout\,
	clk => \U_PLL|altpll_component|auto_generated|pll1_CLK_bus\);

-- Location: CLKCTRL_G3
\U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\);

-- Location: IOIBUF_X31_Y17_N8
\AD[8]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(8),
	o => \AD[8]~input_o\);

-- Location: LCCOMB_X20_Y21_N24
\U_GPMC_IF|wAD[8]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAD[8]~feeder_combout\ = \AD[8]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \AD[8]~input_o\,
	combout => \U_GPMC_IF|wAD[8]~feeder_combout\);

-- Location: FF_X17_Y14_N1
syn_reset_n : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_PLL|altpll_component|auto_generated|wire_pll1_locked\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \syn_reset_n~q\);

-- Location: FF_X20_Y21_N25
\U_GPMC_IF|wAD[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAD[8]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(8));

-- Location: LCCOMB_X16_Y21_N8
\U_GPMC_IF|iDataWr[8]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|iDataWr[8]~feeder_combout\ = \U_GPMC_IF|wAD\(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(8),
	combout => \U_GPMC_IF|iDataWr[8]~feeder_combout\);

-- Location: LCCOMB_X17_Y14_N6
\U_GPMC_IF|wCS_L~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wCS_L~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \U_GPMC_IF|wCS_L~feeder_combout\);

-- Location: FF_X17_Y14_N7
\U_GPMC_IF|wCS_L\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wCS_L~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wCS_L~q\);

-- Location: IOIBUF_X10_Y20_N22
\RD_L~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RD_L,
	o => \RD_L~input_o\);

-- Location: LCCOMB_X17_Y14_N8
\U_GPMC_IF|wOE_L~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wOE_L~0_combout\ = !\RD_L~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \RD_L~input_o\,
	combout => \U_GPMC_IF|wOE_L~0_combout\);

-- Location: FF_X17_Y14_N9
\U_GPMC_IF|wOE_L\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wOE_L~0_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wOE_L~q\);

-- Location: IOIBUF_X10_Y19_N22
\WE_L~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_WE_L,
	o => \WE_L~input_o\);

-- Location: LCCOMB_X17_Y14_N12
\U_GPMC_IF|wWE_L~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wWE_L~0_combout\ = !\WE_L~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \WE_L~input_o\,
	combout => \U_GPMC_IF|wWE_L~0_combout\);

-- Location: FF_X17_Y14_N13
\U_GPMC_IF|wWE_L\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wWE_L~0_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wWE_L~q\);

-- Location: FF_X17_Y14_N19
\U_GPMC_IF|wWE_L_DL1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wWE_L~q\,
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wWE_L_DL1~q\);

-- Location: LCCOMB_X17_Y14_N18
\U_GPMC_IF|iDataWr[8]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|iDataWr[8]~0_combout\ = (\U_GPMC_IF|wCS_L~q\ & (!\U_GPMC_IF|wOE_L~q\ & (!\U_GPMC_IF|wWE_L_DL1~q\ & \U_GPMC_IF|wWE_L~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_GPMC_IF|wCS_L~q\,
	datab => \U_GPMC_IF|wOE_L~q\,
	datac => \U_GPMC_IF|wWE_L_DL1~q\,
	datad => \U_GPMC_IF|wWE_L~q\,
	combout => \U_GPMC_IF|iDataWr[8]~0_combout\);

-- Location: FF_X16_Y21_N9
\U_GPMC_IF|iDataWr[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|iDataWr[8]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(8));

-- Location: IOIBUF_X31_Y19_N22
\AD[14]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(14),
	o => \AD[14]~input_o\);

-- Location: FF_X20_Y21_N27
\U_GPMC_IF|wAD[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \AD[14]~input_o\,
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(14));

-- Location: IOIBUF_X10_Y20_N15
\ADV_L~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADV_L,
	o => \ADV_L~input_o\);

-- Location: LCCOMB_X17_Y14_N26
\U_GPMC_IF|wADV_L~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wADV_L~0_combout\ = !\ADV_L~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \ADV_L~input_o\,
	combout => \U_GPMC_IF|wADV_L~0_combout\);

-- Location: FF_X17_Y14_N27
\U_GPMC_IF|wADV_L\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wADV_L~0_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wADV_L~q\);

-- Location: FF_X17_Y14_N25
\U_GPMC_IF|wADV_L_DL1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wADV_L~q\,
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wADV_L_DL1~q\);

-- Location: LCCOMB_X17_Y14_N24
\U_GPMC_IF|process_2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|process_2~0_combout\ = (!\U_GPMC_IF|wADV_L~q\ & (\U_GPMC_IF|wADV_L_DL1~q\ & \U_GPMC_IF|wCS_L~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_GPMC_IF|wADV_L~q\,
	datac => \U_GPMC_IF|wADV_L_DL1~q\,
	datad => \U_GPMC_IF|wCS_L~q\,
	combout => \U_GPMC_IF|process_2~0_combout\);

-- Location: FF_X17_Y20_N31
\U_GPMC_IF|wAddr[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wAD\(14),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(14));

-- Location: IOIBUF_X31_Y19_N15
\AD[15]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(15),
	o => \AD[15]~input_o\);

-- Location: LCCOMB_X17_Y14_N14
\U_GPMC_IF|wAD[15]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAD[15]~feeder_combout\ = \AD[15]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \AD[15]~input_o\,
	combout => \U_GPMC_IF|wAD[15]~feeder_combout\);

-- Location: FF_X17_Y14_N15
\U_GPMC_IF|wAD[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAD[15]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(15));

-- Location: FF_X17_Y20_N21
\U_GPMC_IF|wAddr[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wAD\(15),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(15));

-- Location: IOIBUF_X27_Y25_N29
\AD[12]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(12),
	o => \AD[12]~input_o\);

-- Location: LCCOMB_X20_Y21_N4
\U_GPMC_IF|wAD[12]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAD[12]~feeder_combout\ = \AD[12]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \AD[12]~input_o\,
	combout => \U_GPMC_IF|wAD[12]~feeder_combout\);

-- Location: FF_X20_Y21_N5
\U_GPMC_IF|wAD[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAD[12]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(12));

-- Location: FF_X17_Y20_N25
\U_GPMC_IF|wAddr[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wAD\(12),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(12));

-- Location: IOIBUF_X24_Y25_N15
\AD[13]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(13),
	o => \AD[13]~input_o\);

-- Location: LCCOMB_X17_Y21_N28
\U_GPMC_IF|wAD[13]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAD[13]~feeder_combout\ = \AD[13]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \AD[13]~input_o\,
	combout => \U_GPMC_IF|wAD[13]~feeder_combout\);

-- Location: FF_X17_Y21_N29
\U_GPMC_IF|wAD[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAD[13]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(13));

-- Location: LCCOMB_X17_Y21_N8
\U_GPMC_IF|wAddr[13]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAddr[13]~feeder_combout\ = \U_GPMC_IF|wAD\(13)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(13),
	combout => \U_GPMC_IF|wAddr[13]~feeder_combout\);

-- Location: FF_X17_Y21_N9
\U_GPMC_IF|wAddr[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAddr[13]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(13));

-- Location: LCCOMB_X17_Y20_N24
\U_TEST_IP|Mux7~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|Mux7~0_combout\ = (!\U_GPMC_IF|wAddr\(14) & (!\U_GPMC_IF|wAddr\(15) & (!\U_GPMC_IF|wAddr\(12) & !\U_GPMC_IF|wAddr\(13))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_GPMC_IF|wAddr\(14),
	datab => \U_GPMC_IF|wAddr\(15),
	datac => \U_GPMC_IF|wAddr\(12),
	datad => \U_GPMC_IF|wAddr\(13),
	combout => \U_TEST_IP|Mux7~0_combout\);

-- Location: LCCOMB_X17_Y14_N20
\U_GPMC_IF|wpWE~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wpWE~0_combout\ = (\U_GPMC_IF|wpWE~q\) # (!\U_GPMC_IF|wOE_L~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U_GPMC_IF|wOE_L~q\,
	datad => \U_GPMC_IF|wpWE~q\,
	combout => \U_GPMC_IF|wpWE~0_combout\);

-- Location: LCCOMB_X17_Y14_N2
\U_GPMC_IF|wpWE~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wpWE~1_combout\ = (\U_GPMC_IF|wCS_L~q\ & (\U_GPMC_IF|wpWE~0_combout\ & (\U_GPMC_IF|wWE_L~q\ & !\U_GPMC_IF|wWE_L_DL1~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_GPMC_IF|wCS_L~q\,
	datab => \U_GPMC_IF|wpWE~0_combout\,
	datac => \U_GPMC_IF|wWE_L~q\,
	datad => \U_GPMC_IF|wWE_L_DL1~q\,
	combout => \U_GPMC_IF|wpWE~1_combout\);

-- Location: FF_X17_Y14_N3
\U_GPMC_IF|wpWE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wpWE~1_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wpWE~q\);

-- Location: IOIBUF_X6_Y10_N1
\AD[11]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(11),
	o => \AD[11]~input_o\);

-- Location: LCCOMB_X17_Y14_N4
\U_GPMC_IF|wAD[11]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAD[11]~feeder_combout\ = \AD[11]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \AD[11]~input_o\,
	combout => \U_GPMC_IF|wAD[11]~feeder_combout\);

-- Location: FF_X17_Y14_N5
\U_GPMC_IF|wAD[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAD[11]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(11));

-- Location: LCCOMB_X17_Y21_N18
\U_GPMC_IF|wAddr[11]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAddr[11]~feeder_combout\ = \U_GPMC_IF|wAD\(11)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(11),
	combout => \U_GPMC_IF|wAddr[11]~feeder_combout\);

-- Location: FF_X17_Y21_N19
\U_GPMC_IF|wAddr[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAddr[11]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(11));

-- Location: IOIBUF_X15_Y25_N15
\AD[9]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(9),
	o => \AD[9]~input_o\);

-- Location: LCCOMB_X20_Y21_N8
\U_GPMC_IF|wAD[9]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAD[9]~feeder_combout\ = \AD[9]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \AD[9]~input_o\,
	combout => \U_GPMC_IF|wAD[9]~feeder_combout\);

-- Location: FF_X20_Y21_N9
\U_GPMC_IF|wAD[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAD[9]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(9));

-- Location: LCCOMB_X17_Y20_N28
\U_GPMC_IF|wAddr[9]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAddr[9]~feeder_combout\ = \U_GPMC_IF|wAD\(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(9),
	combout => \U_GPMC_IF|wAddr[9]~feeder_combout\);

-- Location: FF_X17_Y20_N29
\U_GPMC_IF|wAddr[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAddr[9]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(9));

-- Location: FF_X17_Y20_N7
\U_GPMC_IF|wAddr[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wAD\(8),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(8));

-- Location: IOIBUF_X27_Y25_N15
\AD[10]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => AD(10),
	o => \AD[10]~input_o\);

-- Location: LCCOMB_X20_Y21_N30
\U_GPMC_IF|wAD[10]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wAD[10]~feeder_combout\ = \AD[10]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \AD[10]~input_o\,
	combout => \U_GPMC_IF|wAD[10]~feeder_combout\);

-- Location: FF_X20_Y21_N31
\U_GPMC_IF|wAD[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wAD[10]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAD\(10));

-- Location: FF_X17_Y20_N11
\U_GPMC_IF|wAddr[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wAD\(10),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_GPMC_IF|process_2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wAddr\(10));

-- Location: LCCOMB_X17_Y20_N6
\U_TEST_IP|Mux7~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|Mux7~1_combout\ = (!\U_GPMC_IF|wAddr\(11) & (!\U_GPMC_IF|wAddr\(9) & (!\U_GPMC_IF|wAddr\(8) & !\U_GPMC_IF|wAddr\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_GPMC_IF|wAddr\(11),
	datab => \U_GPMC_IF|wAddr\(9),
	datac => \U_GPMC_IF|wAddr\(8),
	datad => \U_GPMC_IF|wAddr\(10),
	combout => \U_TEST_IP|Mux7~1_combout\);

-- Location: LCCOMB_X17_Y20_N16
\U_TEST_IP|wLED[8]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|wLED[8]~0_combout\ = (\U_TEST_IP|Mux7~0_combout\ & (\U_GPMC_IF|wpWE~q\ & \U_TEST_IP|Mux7~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U_TEST_IP|Mux7~0_combout\,
	datac => \U_GPMC_IF|wpWE~q\,
	datad => \U_TEST_IP|Mux7~1_combout\,
	combout => \U_TEST_IP|wLED[8]~0_combout\);

-- Location: FF_X17_Y20_N1
\U_TEST_IP|wLED[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|iDataWr\(8),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(8));

-- Location: LCCOMB_X23_Y21_N24
\U_TEST_IP|iDataRd[8]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|iDataRd[8]~feeder_combout\ = \U_TEST_IP|wLED\(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|wLED\(8),
	combout => \U_TEST_IP|iDataRd[8]~feeder_combout\);

-- Location: FF_X17_Y14_N29
\U_GPMC_IF|wOE_L_DL1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wOE_L~q\,
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wOE_L_DL1~q\);

-- Location: LCCOMB_X17_Y14_N10
\U_GPMC_IF|wpRD~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wpRD~0_combout\ = (\U_GPMC_IF|wCS_L~q\ & (\U_GPMC_IF|wOE_L~q\ & ((\U_GPMC_IF|wpRD~q\) # (!\U_GPMC_IF|wWE_L~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_GPMC_IF|wCS_L~q\,
	datab => \U_GPMC_IF|wOE_L~q\,
	datac => \U_GPMC_IF|wWE_L~q\,
	datad => \U_GPMC_IF|wpRD~q\,
	combout => \U_GPMC_IF|wpRD~0_combout\);

-- Location: LCCOMB_X17_Y14_N16
\U_GPMC_IF|wpRD~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wpRD~1_combout\ = (!\U_GPMC_IF|wOE_L_DL1~q\ & \U_GPMC_IF|wpRD~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U_GPMC_IF|wOE_L_DL1~q\,
	datad => \U_GPMC_IF|wpRD~0_combout\,
	combout => \U_GPMC_IF|wpRD~1_combout\);

-- Location: FF_X17_Y14_N17
\U_GPMC_IF|wpRD\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wpRD~1_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wpRD~q\);

-- Location: LCCOMB_X17_Y20_N2
\U_TEST_IP|iDataRd[8]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|iDataRd[8]~0_combout\ = (\U_TEST_IP|Mux7~1_combout\ & (\U_GPMC_IF|wpRD~q\ & \U_TEST_IP|Mux7~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U_TEST_IP|Mux7~1_combout\,
	datab => \U_GPMC_IF|wpRD~q\,
	datad => \U_TEST_IP|Mux7~0_combout\,
	combout => \U_TEST_IP|iDataRd[8]~0_combout\);

-- Location: FF_X23_Y21_N25
\U_TEST_IP|iDataRd[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|iDataRd[8]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(8));

-- Location: LCCOMB_X23_Y21_N0
\U_GPMC_IF|wDataRd[8]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wDataRd[8]~feeder_combout\ = \U_TEST_IP|iDataRd\(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|iDataRd\(8),
	combout => \U_GPMC_IF|wDataRd[8]~feeder_combout\);

-- Location: FF_X23_Y21_N1
\U_GPMC_IF|wDataRd[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wDataRd[8]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(8));

-- Location: LCCOMB_X17_Y14_N22
\U_GPMC_IF|wGate\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wGate~combout\ = (\U_GPMC_IF|wOE_L~q\ & !\U_GPMC_IF|wWE_L~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U_GPMC_IF|wOE_L~q\,
	datad => \U_GPMC_IF|wWE_L~q\,
	combout => \U_GPMC_IF|wGate~combout\);

-- Location: LCCOMB_X14_Y24_N24
\U_GPMC_IF|iDataWr[9]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|iDataWr[9]~feeder_combout\ = \U_GPMC_IF|wAD\(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(9),
	combout => \U_GPMC_IF|iDataWr[9]~feeder_combout\);

-- Location: FF_X14_Y24_N25
\U_GPMC_IF|iDataWr[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|iDataWr[9]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(9));

-- Location: LCCOMB_X17_Y20_N26
\U_TEST_IP|wLED[9]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|wLED[9]~feeder_combout\ = \U_GPMC_IF|iDataWr\(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|iDataWr\(9),
	combout => \U_TEST_IP|wLED[9]~feeder_combout\);

-- Location: FF_X17_Y20_N27
\U_TEST_IP|wLED[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|wLED[9]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(9));

-- Location: FF_X23_Y21_N11
\U_TEST_IP|iDataRd[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|wLED\(9),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(9));

-- Location: LCCOMB_X23_Y21_N2
\U_GPMC_IF|wDataRd[9]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wDataRd[9]~feeder_combout\ = \U_TEST_IP|iDataRd\(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|iDataRd\(9),
	combout => \U_GPMC_IF|wDataRd[9]~feeder_combout\);

-- Location: FF_X23_Y21_N3
\U_GPMC_IF|wDataRd[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wDataRd[9]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(9));

-- Location: FF_X18_Y20_N25
\U_GPMC_IF|iDataWr[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wAD\(10),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(10));

-- Location: LCCOMB_X17_Y20_N12
\U_TEST_IP|wLED[10]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|wLED[10]~feeder_combout\ = \U_GPMC_IF|iDataWr\(10)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|iDataWr\(10),
	combout => \U_TEST_IP|wLED[10]~feeder_combout\);

-- Location: FF_X17_Y20_N13
\U_TEST_IP|wLED[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|wLED[10]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(10));

-- Location: FF_X23_Y21_N13
\U_TEST_IP|iDataRd[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|wLED\(10),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(10));

-- Location: LCCOMB_X23_Y21_N28
\U_GPMC_IF|wDataRd[10]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wDataRd[10]~feeder_combout\ = \U_TEST_IP|iDataRd\(10)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|iDataRd\(10),
	combout => \U_GPMC_IF|wDataRd[10]~feeder_combout\);

-- Location: FF_X23_Y21_N29
\U_GPMC_IF|wDataRd[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wDataRd[10]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(10));

-- Location: LCCOMB_X14_Y24_N10
\U_GPMC_IF|iDataWr[11]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|iDataWr[11]~feeder_combout\ = \U_GPMC_IF|wAD\(11)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(11),
	combout => \U_GPMC_IF|iDataWr[11]~feeder_combout\);

-- Location: FF_X14_Y24_N11
\U_GPMC_IF|iDataWr[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|iDataWr[11]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(11));

-- Location: LCCOMB_X17_Y20_N22
\U_TEST_IP|wLED[11]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|wLED[11]~feeder_combout\ = \U_GPMC_IF|iDataWr\(11)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|iDataWr\(11),
	combout => \U_TEST_IP|wLED[11]~feeder_combout\);

-- Location: FF_X17_Y20_N23
\U_TEST_IP|wLED[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|wLED[11]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(11));

-- Location: LCCOMB_X23_Y21_N14
\U_TEST_IP|iDataRd[11]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|iDataRd[11]~feeder_combout\ = \U_TEST_IP|wLED\(11)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|wLED\(11),
	combout => \U_TEST_IP|iDataRd[11]~feeder_combout\);

-- Location: FF_X23_Y21_N15
\U_TEST_IP|iDataRd[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|iDataRd[11]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(11));

-- Location: FF_X23_Y21_N23
\U_GPMC_IF|wDataRd[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|iDataRd\(11),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(11));

-- Location: LCCOMB_X14_Y24_N12
\U_GPMC_IF|iDataWr[12]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|iDataWr[12]~feeder_combout\ = \U_GPMC_IF|wAD\(12)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(12),
	combout => \U_GPMC_IF|iDataWr[12]~feeder_combout\);

-- Location: FF_X14_Y24_N13
\U_GPMC_IF|iDataWr[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|iDataWr[12]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(12));

-- Location: LCCOMB_X17_Y20_N8
\U_TEST_IP|wLED[12]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|wLED[12]~feeder_combout\ = \U_GPMC_IF|iDataWr\(12)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|iDataWr\(12),
	combout => \U_TEST_IP|wLED[12]~feeder_combout\);

-- Location: FF_X17_Y20_N9
\U_TEST_IP|wLED[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|wLED[12]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(12));

-- Location: FF_X23_Y21_N9
\U_TEST_IP|iDataRd[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|wLED\(12),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(12));

-- Location: FF_X23_Y21_N17
\U_GPMC_IF|wDataRd[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|iDataRd\(12),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(12));

-- Location: FF_X14_Y24_N23
\U_GPMC_IF|iDataWr[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|wAD\(13),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(13));

-- Location: LCCOMB_X17_Y20_N18
\U_TEST_IP|wLED[13]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|wLED[13]~feeder_combout\ = \U_GPMC_IF|iDataWr\(13)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|iDataWr\(13),
	combout => \U_TEST_IP|wLED[13]~feeder_combout\);

-- Location: FF_X17_Y20_N19
\U_TEST_IP|wLED[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|wLED[13]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(13));

-- Location: LCCOMB_X23_Y21_N18
\U_TEST_IP|iDataRd[13]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|iDataRd[13]~feeder_combout\ = \U_TEST_IP|wLED\(13)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|wLED\(13),
	combout => \U_TEST_IP|iDataRd[13]~feeder_combout\);

-- Location: FF_X23_Y21_N19
\U_TEST_IP|iDataRd[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|iDataRd[13]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(13));

-- Location: LCCOMB_X23_Y21_N26
\U_GPMC_IF|wDataRd[13]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|wDataRd[13]~feeder_combout\ = \U_TEST_IP|iDataRd\(13)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|iDataRd\(13),
	combout => \U_GPMC_IF|wDataRd[13]~feeder_combout\);

-- Location: FF_X23_Y21_N27
\U_GPMC_IF|wDataRd[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|wDataRd[13]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(13));

-- Location: LCCOMB_X14_Y24_N0
\U_GPMC_IF|iDataWr[14]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|iDataWr[14]~feeder_combout\ = \U_GPMC_IF|wAD\(14)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(14),
	combout => \U_GPMC_IF|iDataWr[14]~feeder_combout\);

-- Location: FF_X14_Y24_N1
\U_GPMC_IF|iDataWr[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|iDataWr[14]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(14));

-- Location: FF_X17_Y20_N5
\U_TEST_IP|wLED[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_GPMC_IF|iDataWr\(14),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(14));

-- Location: LCCOMB_X23_Y21_N4
\U_TEST_IP|iDataRd[14]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|iDataRd[14]~feeder_combout\ = \U_TEST_IP|wLED\(14)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_TEST_IP|wLED\(14),
	combout => \U_TEST_IP|iDataRd[14]~feeder_combout\);

-- Location: FF_X23_Y21_N5
\U_TEST_IP|iDataRd[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|iDataRd[14]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(14));

-- Location: FF_X23_Y21_N21
\U_GPMC_IF|wDataRd[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|iDataRd\(14),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(14));

-- Location: LCCOMB_X14_Y24_N2
\U_GPMC_IF|iDataWr[15]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_GPMC_IF|iDataWr[15]~feeder_combout\ = \U_GPMC_IF|wAD\(15)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|wAD\(15),
	combout => \U_GPMC_IF|iDataWr[15]~feeder_combout\);

-- Location: FF_X14_Y24_N3
\U_GPMC_IF|iDataWr[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_GPMC_IF|iDataWr[15]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_GPMC_IF|iDataWr[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|iDataWr\(15));

-- Location: LCCOMB_X17_Y20_N14
\U_TEST_IP|wLED[15]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \U_TEST_IP|wLED[15]~feeder_combout\ = \U_GPMC_IF|iDataWr\(15)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U_GPMC_IF|iDataWr\(15),
	combout => \U_TEST_IP|wLED[15]~feeder_combout\);

-- Location: FF_X17_Y20_N15
\U_TEST_IP|wLED[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \U_TEST_IP|wLED[15]~feeder_combout\,
	clrn => \syn_reset_n~q\,
	ena => \U_TEST_IP|wLED[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|wLED\(15));

-- Location: FF_X23_Y21_N31
\U_TEST_IP|iDataRd[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|wLED\(15),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	ena => \U_TEST_IP|iDataRd[8]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_TEST_IP|iDataRd\(15));

-- Location: FF_X23_Y21_N7
\U_GPMC_IF|wDataRd[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \U_PLL|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \U_TEST_IP|iDataRd\(15),
	clrn => \syn_reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U_GPMC_IF|wDataRd\(15));

-- Location: IOIBUF_X11_Y25_N29
\SW_TACT[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW_TACT(0),
	o => \SW_TACT[0]~input_o\);

-- Location: IOIBUF_X13_Y25_N29
\SW_TACT[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW_TACT(1),
	o => \SW_TACT[1]~input_o\);

-- Location: UNVM_X0_Y11_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X10_Y24_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);
END structure;


