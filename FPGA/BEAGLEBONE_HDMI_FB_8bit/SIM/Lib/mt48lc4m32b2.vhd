-------------------------------------------------------------------------------
--  File Name: mt48lc4m32b2.vhd
-------------------------------------------------------------------------------
--  Copyright (C) 2006 Free Model Foundry; http://www.freemodelfoundry.com
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License version 2 as
--  published by the Free Software Foundation.
--
--  MODIFICATION HISTORY:
--
--  version: |  author:       |  mod date:  | changes made:
--    V1.0     I.Milutinovic     06 Apr 18    Initial release
--
-------------------------------------------------------------------------------
--  PART DESCRIPTION:
--
--  Library:    RAM
--  Technology: LVTTL
--  Part:       MT48LC4M32B2
--
--  Description: 128Mb (1M x 32 x 4Banks) SDRAM
-------------------------------------------------------------------------------

LIBRARY IEEE;   USE IEEE.std_logic_1164.ALL;
                USE IEEE.VITAL_timing.ALL;
                USE IEEE.VITAL_primitives.ALL;
                USE STD.textio.ALL;

   USE work.gen_utils.ALL;
                USE work.conversions.ALL;

-------------------------------------------------------------------------------
-- ENTITY DECLARATION
-------------------------------------------------------------------------------
ENTITY mt48lc4m32b2 IS
    GENERIC (
        -- tipd delays: interconnect path delays
        tipd_BA0        : VitalDelayType01 := VitalZeroDelay01;
        tipd_BA1        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQM3       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQM2       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQM1       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQM0       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ0        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ1        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ2        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ3        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ4        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ5        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ6        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ7        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ8        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ9        : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ10       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ11       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ12       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ13       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ14       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ15       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ16       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ17       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ18       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ19       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ20       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ21       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ22       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ23       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ24       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ25       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ26       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ27       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ28       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ29       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ30       : VitalDelayType01 := VitalZeroDelay01;
        tipd_DQ31       : VitalDelayType01 := VitalZeroDelay01;
        tipd_CLK        : VitalDelayType01 := VitalZeroDelay01;
        tipd_CKE        : VitalDelayType01 := VitalZeroDelay01;
        tipd_A0         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A1         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A2         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A3         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A4         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A5         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A6         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A7         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A8         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A9         : VitalDelayType01 := VitalZeroDelay01;
        tipd_A10        : VitalDelayType01 := VitalZeroDelay01;
        tipd_A11        : VitalDelayType01 := VitalZeroDelay01;
        tipd_WENeg      : VitalDelayType01 := VitalZeroDelay01;
        tipd_RASNeg     : VitalDelayType01 := VitalZeroDelay01;
        tipd_CSNeg      : VitalDelayType01 := VitalZeroDelay01;
        tipd_CASNeg     : VitalDelayType01 := VitalZeroDelay01;
        -- tpd delays
        tpd_CLK_DQ1              : VitalDelayType01Z := UnitDelay01Z;
        tpd_CLK_DQ2              : VitalDelayType01Z := UnitDelay01Z;
        tpd_CLK_DQ3              : VitalDelayType01Z := UnitDelay01Z;-- tAC
        -- tpw values: pulse widths
        tpw_CLK_posedge          : VitalDelayType    := UnitDelay;-- tCH
        tpw_CLK_negedge          : VitalDelayType    := UnitDelay;-- tCL
        -- tsetup values: setup times
        tsetup_DQ0_CLK           : VitalDelayType    := UnitDelay;-- tDS
        -- thold values: hold times
        thold_DQ0_CLK            : VitalDelayType    := UnitDelay;-- tDH
        -- tperiod_min: minimum clock period = 1/max freq
        tperiod_CLK_cl0_eq_1_posedge   : VitalDelayType    := UnitDelay;--tCK
        tperiod_CLK_cl1_eq_1_posedge   : VitalDelayType    := UnitDelay;
        tperiod_CLK_cl2_eq_1_posedge   : VitalDelayType    := UnitDelay;
        -- tdevice values: values for internal delays
        tdevice_REF              : VitalDelayType    := 15_625 ns;
        tdevice_TRC              : VitalDelayType    := 70 ns;
        tdevice_TRCD             : VitalDelayType    := 20 ns;
        tdevice_TRP              : VitalDelayType    := 20 ns;
        tdevice_TRCAR            : VitalDelayType    := 70 ns;
        tdevice_TWR              : VitalDelayType    := 14 ns;
        tdevice_TRAS             : VitalDelayType01  := (42 ns, 120_000 ns);
        -- tpowerup: Power up initialization time. Data sheets say 100 us.
        -- May be shortened during simulation debug.
        tpowerup        : TIME      := 100 us;
        -- generic control parameters
        InstancePath    : STRING    := DefaultInstancePath;
        TimingChecksOn  : BOOLEAN   := DefaultTimingChecks;
        MsgOn           : BOOLEAN   := DefaultMsgOn;
        XOn             : BOOLEAN   := DefaultXon;
        SeverityMode    : SEVERITY_LEVEL := WARNING;
        -- memory file to be loaded
        mem_file_name   : STRING    := "mt48lc4m32b2.mem";
        -- preload variable
        UserPreload     : BOOLEAN   := FALSE;
        -- For FMF SDF technology file usage
        TimingModel     : STRING    := DefaultTimingModel
    );
    PORT (
        BA0       : IN    std_logic := 'U';
        BA1       : IN    std_logic := 'U';
        DQM3      : IN    std_logic := 'U';
        DQM2      : IN    std_logic := 'U';
        DQM1      : IN    std_logic := 'U';
        DQM0      : IN    std_logic := 'U';
        DQ0       : INOUT std_logic := 'U';
        DQ1       : INOUT std_logic := 'U';
        DQ2       : INOUT std_logic := 'U';
        DQ3       : INOUT std_logic := 'U';
        DQ4       : INOUT std_logic := 'U';
        DQ5       : INOUT std_logic := 'U';
        DQ6       : INOUT std_logic := 'U';
        DQ7       : INOUT std_logic := 'U';
        DQ8       : INOUT std_logic := 'U';
        DQ9       : INOUT std_logic := 'U';
        DQ10      : INOUT std_logic := 'U';
        DQ11      : INOUT std_logic := 'U';
        DQ12      : INOUT std_logic := 'U';
        DQ13      : INOUT std_logic := 'U';
        DQ14      : INOUT std_logic := 'U';
        DQ15      : INOUT std_logic := 'U';
        DQ16      : INOUT std_logic := 'U';
        DQ17      : INOUT std_logic := 'U';
        DQ18      : INOUT std_logic := 'U';
        DQ19      : INOUT std_logic := 'U';
        DQ20      : INOUT std_logic := 'U';
        DQ21      : INOUT std_logic := 'U';
        DQ22      : INOUT std_logic := 'U';
        DQ23      : INOUT std_logic := 'U';
        DQ24      : INOUT std_logic := 'U';
        DQ25      : INOUT std_logic := 'U';
        DQ26      : INOUT std_logic := 'U';
        DQ27      : INOUT std_logic := 'U';
        DQ28      : INOUT std_logic := 'U';
        DQ29      : INOUT std_logic := 'U';
        DQ30      : INOUT std_logic := 'U';
        DQ31      : INOUT std_logic := 'U';
        CLK       : IN    std_logic := 'U';
        CKE       : IN    std_logic := 'U';
        A0        : IN    std_logic := 'U';
        A1        : IN    std_logic := 'U';
        A2        : IN    std_logic := 'U';
        A3        : IN    std_logic := 'U';
        A4        : IN    std_logic := 'U';
        A5        : IN    std_logic := 'U';
        A6        : IN    std_logic := 'U';
        A7        : IN    std_logic := 'U';
        A8        : IN    std_logic := 'U';
        A9        : IN    std_logic := 'U';
        A10       : IN    std_logic := 'U';
        A11       : IN    std_logic := 'U';
        WENeg     : IN    std_logic := 'U';
        RASNeg    : IN    std_logic := 'U';
        CSNeg     : IN    std_logic := 'U';
        CASNeg    : IN    std_logic := 'U'
    );
    ATTRIBUTE VITAL_LEVEL0 of mt48lc4m32b2 : ENTITY IS TRUE;
END mt48lc4m32b2;

-------------------------------------------------------------------------------
-- ARCHITECTURE DECLARATION
-------------------------------------------------------------------------------
ARCHITECTURE vhdl_behavioral of mt48lc4m32b2 IS
    ATTRIBUTE VITAL_LEVEL0 of vhdl_behavioral : ARCHITECTURE IS TRUE;

    CONSTANT PartID    : STRING  := "mt48lc4m32b2";
    CONSTANT hi_bank   : NATURAL := 3;
    CONSTANT depth     : NATURAL := 16#100000#;

    SIGNAL CKEreg      : X01     := 'X';
    SIGNAL PoweredUp   : boolean := false;

    SIGNAL BA0_ipd     : std_ulogic := 'X';
    SIGNAL BA1_ipd     : std_ulogic := 'X';
    SIGNAL DQM0_ipd    : std_ulogic := 'X';
    SIGNAL DQM1_ipd    : std_ulogic := 'X';
    SIGNAL DQM2_ipd    : std_ulogic := 'X';
    SIGNAL DQM3_ipd    : std_ulogic := 'X';
    SIGNAL DQ0_ipd     : std_ulogic := 'X';
    SIGNAL DQ1_ipd     : std_ulogic := 'X';
    SIGNAL DQ2_ipd     : std_ulogic := 'X';
    SIGNAL DQ3_ipd     : std_ulogic := 'X';
    SIGNAL DQ4_ipd     : std_ulogic := 'X';
    SIGNAL DQ5_ipd     : std_ulogic := 'X';
    SIGNAL DQ6_ipd     : std_ulogic := 'X';
    SIGNAL DQ7_ipd     : std_ulogic := 'X';
    SIGNAL DQ8_ipd     : std_ulogic := 'X';
    SIGNAL DQ9_ipd     : std_ulogic := 'X';
    SIGNAL DQ10_ipd    : std_ulogic := 'X';
    SIGNAL DQ11_ipd    : std_ulogic := 'X';
    SIGNAL DQ12_ipd    : std_ulogic := 'X';
    SIGNAL DQ13_ipd    : std_ulogic := 'X';
    SIGNAL DQ14_ipd    : std_ulogic := 'X';
    SIGNAL DQ15_ipd    : std_ulogic := 'X';
    SIGNAL DQ16_ipd    : std_ulogic := 'X';
    SIGNAL DQ17_ipd    : std_ulogic := 'X';
    SIGNAL DQ18_ipd    : std_ulogic := 'X';
    SIGNAL DQ19_ipd    : std_ulogic := 'X';
    SIGNAL DQ20_ipd    : std_ulogic := 'X';
    SIGNAL DQ21_ipd    : std_ulogic := 'X';
    SIGNAL DQ22_ipd    : std_ulogic := 'X';
    SIGNAL DQ23_ipd    : std_ulogic := 'X';
    SIGNAL DQ24_ipd    : std_ulogic := 'X';
    SIGNAL DQ25_ipd    : std_ulogic := 'X';
    SIGNAL DQ26_ipd    : std_ulogic := 'X';
    SIGNAL DQ27_ipd    : std_ulogic := 'X';
    SIGNAL DQ28_ipd    : std_ulogic := 'X';
    SIGNAL DQ29_ipd    : std_ulogic := 'X';
    SIGNAL DQ30_ipd    : std_ulogic := 'X';
    SIGNAL DQ31_ipd    : std_ulogic := 'X';
    SIGNAL CLK_ipd     : std_ulogic := 'X';
    SIGNAL CKE_ipd     : std_ulogic := 'X';
    SIGNAL A0_ipd      : std_ulogic := 'X';
    SIGNAL A1_ipd      : std_ulogic := 'X';
    SIGNAL A2_ipd      : std_ulogic := 'X';
    SIGNAL A3_ipd      : std_ulogic := 'X';
    SIGNAL A4_ipd      : std_ulogic := 'X';
    SIGNAL A5_ipd      : std_ulogic := 'X';
    SIGNAL A6_ipd      : std_ulogic := 'X';
    SIGNAL A7_ipd      : std_ulogic := 'X';
    SIGNAL A8_ipd      : std_ulogic := 'X';
    SIGNAL A9_ipd      : std_ulogic := 'X';
    SIGNAL A10_ipd     : std_ulogic := 'X';
    SIGNAL A11_ipd     : std_ulogic := 'X';
    SIGNAL WENeg_ipd   : std_ulogic := 'X';
    SIGNAL RASNeg_ipd  : std_ulogic := 'X';
    SIGNAL CSNeg_ipd   : std_ulogic := 'X';
    SIGNAL CASNeg_ipd  : std_ulogic := 'X';

    SIGNAL BA0_nwv     : std_ulogic := 'X';
    SIGNAL BA1_nwv     : std_ulogic := 'X';
    SIGNAL DQM0_nwv    : std_ulogic := 'X';
    SIGNAL DQM1_nwv    : std_ulogic := 'X';
    SIGNAL DQM2_nwv    : std_ulogic := 'X';
    SIGNAL DQM3_nwv    : std_ulogic := 'X';
    SIGNAL DQ0_nwv     : std_ulogic := 'X';
    SIGNAL DQ1_nwv     : std_ulogic := 'X';
    SIGNAL DQ2_nwv     : std_ulogic := 'X';
    SIGNAL DQ3_nwv     : std_ulogic := 'X';
    SIGNAL DQ4_nwv     : std_ulogic := 'X';
    SIGNAL DQ5_nwv     : std_ulogic := 'X';
    SIGNAL DQ6_nwv     : std_ulogic := 'X';
    SIGNAL DQ7_nwv     : std_ulogic := 'X';
    SIGNAL DQ8_nwv     : std_ulogic := 'X';
    SIGNAL DQ9_nwv     : std_ulogic := 'X';
    SIGNAL DQ10_nwv    : std_ulogic := 'X';
    SIGNAL DQ11_nwv    : std_ulogic := 'X';
    SIGNAL DQ12_nwv    : std_ulogic := 'X';
    SIGNAL DQ13_nwv    : std_ulogic := 'X';
    SIGNAL DQ14_nwv    : std_ulogic := 'X';
    SIGNAL DQ15_nwv    : std_ulogic := 'X';
    SIGNAL DQ16_nwv    : std_ulogic := 'X';
    SIGNAL DQ17_nwv    : std_ulogic := 'X';
    SIGNAL DQ18_nwv    : std_ulogic := 'X';
    SIGNAL DQ19_nwv    : std_ulogic := 'X';
    SIGNAL DQ20_nwv    : std_ulogic := 'X';
    SIGNAL DQ21_nwv    : std_ulogic := 'X';
    SIGNAL DQ22_nwv    : std_ulogic := 'X';
    SIGNAL DQ23_nwv    : std_ulogic := 'X';
    SIGNAL DQ24_nwv    : std_ulogic := 'X';
    SIGNAL DQ25_nwv    : std_ulogic := 'X';
    SIGNAL DQ26_nwv    : std_ulogic := 'X';
    SIGNAL DQ27_nwv    : std_ulogic := 'X';
    SIGNAL DQ28_nwv    : std_ulogic := 'X';
    SIGNAL DQ29_nwv    : std_ulogic := 'X';
    SIGNAL DQ30_nwv    : std_ulogic := 'X';
    SIGNAL DQ31_nwv    : std_ulogic := 'X';
    SIGNAL A0_nwv      : std_ulogic := 'X';
    SIGNAL A1_nwv      : std_ulogic := 'X';
    SIGNAL A2_nwv      : std_ulogic := 'X';
    SIGNAL A3_nwv      : std_ulogic := 'X';
    SIGNAL A4_nwv      : std_ulogic := 'X';
    SIGNAL A5_nwv      : std_ulogic := 'X';
    SIGNAL A6_nwv      : std_ulogic := 'X';
    SIGNAL A7_nwv      : std_ulogic := 'X';
    SIGNAL A8_nwv      : std_ulogic := 'X';
    SIGNAL A9_nwv      : std_ulogic := 'X';
    SIGNAL A10_nwv     : std_ulogic := 'X';
    SIGNAL A11_nwv     : std_ulogic := 'X';
    SIGNAL CLK_nwv     : std_ulogic := 'X';
    SIGNAL CKE_nwv     : std_ulogic := 'X';
    SIGNAL WENeg_nwv   : std_ulogic := 'X';
    SIGNAL RASNeg_nwv  : std_ulogic := 'X';
    SIGNAL CSNeg_nwv   : std_ulogic := 'X';
    SIGNAL CASNeg_nwv  : std_ulogic := 'X';

    SIGNAL rct_in        : std_ulogic := '0';
    SIGNAL rct_out       : std_ulogic := '0';
    SIGNAL rcdt_in       : std_ulogic_vector(3 downto 0) := (others => '0');
    SIGNAL rcdt_out      : std_ulogic_vector(3 downto 0) := (others => '0');
    SIGNAL pre_in        : std_ulogic := '0';
    SIGNAL pre_out       : std_ulogic := '0';
    SIGNAL refreshed_in  : std_ulogic := '0';
    SIGNAL refreshed_out : std_ulogic := '0';
    SIGNAL rcar_out      : std_ulogic := '0';
    SIGNAL rcar_in       : std_ulogic := '0';
    SIGNAL wrt_in        : std_ulogic := '0';
    SIGNAL wrt_out       : std_ulogic := '0';
    SIGNAL ras_in        : std_ulogic_vector(3 downto 0) := (others => '0');
    SIGNAL ras_out       : std_ulogic_vector(3 downto 0) := (others => '0');

BEGIN

    ---------------------------------------------------------------------------
    -- Internal Delays
    ---------------------------------------------------------------------------
    -- Artificial VITAL primitives to incorporate internal delays
    REF   : VitalBuf (refreshed_out, refreshed_in, (UnitDelay, tdevice_REF));
    TRC   : VitalBuf (rct_out      , rct_in      , (tdevice_TRC, UnitDelay));
    TRCD  : VitalBuf (rcdt_out(0)  , rcdt_in(0)  , (UnitDelay, tdevice_TRCD));
    TRCD1 : VitalBuf (rcdt_out(1)  , rcdt_in(1)  , (UnitDelay, tdevice_TRCD));
    TRCD2 : VitalBuf (rcdt_out(2)  , rcdt_in(2)  , (UnitDelay, tdevice_TRCD));
    TRCD3 : VitalBuf (rcdt_out(3)  , rcdt_in(3)  , (UnitDelay, tdevice_TRCD));
    TRP   : VitalBuf (pre_out      , pre_in      , (tdevice_TRP  , UnitDelay));
    TRCAR : VitalBuf (rcar_out     , rcar_in     , (tdevice_TRCAR, UnitDelay));
    TWR   : VitalBuf (wrt_out      , wrt_in      , (tdevice_TWR  , UnitDelay));
    TRAS  : VitalBuf (ras_out(0)   , ras_in(0)   , tdevice_TRAS);
    TRAS1 : VitalBuf (ras_out(1)   , ras_in(1)   , tdevice_TRAS);
    TRAS2 : VitalBuf (ras_out(2)   , ras_in(2)   , tdevice_TRAS);
    TRAS3 : VitalBuf (ras_out(3)   , ras_in(3)   , tdevice_TRAS);

    ---------------------------------------------------------------------------
    -- Wire Delays
    ---------------------------------------------------------------------------
    WireDelay : BLOCK
    BEGIN

        w_1  : VitalWireDelay (BA0_ipd, BA0, tipd_BA0);
        w_2  : VitalWireDelay (BA1_ipd, BA1, tipd_BA1);
        w_3  : VitalWireDelay (DQM0_ipd, DQM0, tipd_DQM0);
        w_4  : VitalWireDelay (DQM1_ipd, DQM1, tipd_DQM1);
        w_5  : VitalWireDelay (DQM2_ipd, DQM2, tipd_DQM2);
        w_6  : VitalWireDelay (DQM3_ipd, DQM3, tipd_DQM3);
        w_7  : VitalWireDelay (DQ0_ipd, DQ0, tipd_DQ0);
        w_8  : VitalWireDelay (DQ1_ipd, DQ1, tipd_DQ1);
        w_9  : VitalWireDelay (DQ2_ipd, DQ2, tipd_DQ2);
        w_10 : VitalWireDelay (DQ3_ipd, DQ3, tipd_DQ3);
        w_11 : VitalWireDelay (DQ4_ipd, DQ4, tipd_DQ4);
        w_12 : VitalWireDelay (DQ5_ipd, DQ5, tipd_DQ5);
        w_13 : VitalWireDelay (DQ6_ipd, DQ6, tipd_DQ6);
        w_14 : VitalWireDelay (DQ7_ipd, DQ7, tipd_DQ7);
        w_15 : VitalWireDelay (DQ8_ipd, DQ8, tipd_DQ8);
        w_16 : VitalWireDelay (DQ9_ipd, DQ9, tipd_DQ9);
        w_17 : VitalWireDelay (DQ10_ipd, DQ10, tipd_DQ10);
        w_18 : VitalWireDelay (DQ11_ipd, DQ11, tipd_DQ11);
        w_19 : VitalWireDelay (DQ12_ipd, DQ12, tipd_DQ12);
        w_20 : VitalWireDelay (DQ13_ipd, DQ13, tipd_DQ13);
        w_21 : VitalWireDelay (DQ14_ipd, DQ14, tipd_DQ14);
        w_22 : VitalWireDelay (DQ15_ipd, DQ15, tipd_DQ15);
        w_23 : VitalWireDelay (DQ16_ipd, DQ16, tipd_DQ16);
        w_24 : VitalWireDelay (DQ17_ipd, DQ17, tipd_DQ17);
        w_25 : VitalWireDelay (DQ18_ipd, DQ18, tipd_DQ18);
        w_26 : VitalWireDelay (DQ19_ipd, DQ19, tipd_DQ19);
        w_27 : VitalWireDelay (DQ20_ipd, DQ20, tipd_DQ20);
        w_28 : VitalWireDelay (DQ21_ipd, DQ21, tipd_DQ21);
        w_29 : VitalWireDelay (DQ22_ipd, DQ22, tipd_DQ22);
        w_30 : VitalWireDelay (DQ23_ipd, DQ23, tipd_DQ23);
        w_31 : VitalWireDelay (DQ24_ipd, DQ24, tipd_DQ24);
        w_32 : VitalWireDelay (DQ25_ipd, DQ25, tipd_DQ25);
        w_33 : VitalWireDelay (DQ26_ipd, DQ26, tipd_DQ26);
        w_34 : VitalWireDelay (DQ27_ipd, DQ27, tipd_DQ27);
        w_35 : VitalWireDelay (DQ28_ipd, DQ28, tipd_DQ28);
        w_36 : VitalWireDelay (DQ29_ipd, DQ29, tipd_DQ29);
        w_37 : VitalWireDelay (DQ30_ipd, DQ30, tipd_DQ30);
        w_38 : VitalWireDelay (DQ31_ipd, DQ31, tipd_DQ31);
        w_39 : VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
        w_40 : VitalWireDelay (CKE_ipd, CKE, tipd_CKE);
        w_41 : VitalWireDelay (A0_ipd, A0, tipd_A0);
        w_42 : VitalWireDelay (A1_ipd, A1, tipd_A1);
        w_43 : VitalWireDelay (A2_ipd, A2, tipd_A2);
        w_44 : VitalWireDelay (A3_ipd, A3, tipd_A3);
        w_45 : VitalWireDelay (A4_ipd, A4, tipd_A4);
        w_46 : VitalWireDelay (A5_ipd, A5, tipd_A5);
        w_47 : VitalWireDelay (A6_ipd, A6, tipd_A6);
        w_48 : VitalWireDelay (A7_ipd, A7, tipd_A7);
        w_49 : VitalWireDelay (A8_ipd, A8, tipd_A8);
        w_50 : VitalWireDelay (A9_ipd, A9, tipd_A9);
        w_51 : VitalWireDelay (A10_ipd, A10, tipd_A10);
        w_52 : VitalWireDelay (A11_ipd, A11, tipd_A11);
        w_53 : VitalWireDelay (WENeg_ipd, WENeg, tipd_WENeg);
        w_54 : VitalWireDelay (RASNeg_ipd, RASNeg, tipd_RASNeg);
        w_55 : VitalWireDelay (CSNeg_ipd, CSNeg, tipd_CSNeg);
        w_56 : VitalWireDelay (CASNeg_ipd, CASNeg, tipd_CASNeg);

    END BLOCK;

    WENeg_nwv  <= To_UX01(WENeg_ipd);
    RASNeg_nwv <= To_UX01(RASNeg_ipd);
    CSNeg_nwv  <= To_UX01(CSNeg_ipd);
    CASNeg_nwv <= To_UX01(CASNeg_ipd);
    CLK_nwv <= To_UX01(CLK_ipd);
    CKE_nwv <= To_UX01(CKE_ipd);
    BA0_nwv <= To_UX01(BA0_ipd);
    BA1_nwv <= To_UX01(BA1_ipd);
    DQM0_nwv <= To_UX01(DQM0_ipd);
    DQM1_nwv <= To_UX01(DQM1_ipd);
    DQM2_nwv <= To_UX01(DQM2_ipd);
    DQM3_nwv <= To_UX01(DQM3_ipd);
    DQ0_nwv <= To_UX01(DQ0_ipd);
    DQ1_nwv <= To_UX01(DQ1_ipd);
    DQ2_nwv <= To_UX01(DQ2_ipd);
    DQ3_nwv <= To_UX01(DQ3_ipd);
    DQ4_nwv <= To_UX01(DQ4_ipd);
    DQ5_nwv <= To_UX01(DQ5_ipd);
    DQ6_nwv <= To_UX01(DQ6_ipd);
    DQ7_nwv <= To_UX01(DQ7_ipd);
    DQ8_nwv <= To_UX01(DQ8_ipd);
    DQ9_nwv <= To_UX01(DQ9_ipd);
    DQ10_nwv <= To_UX01(DQ10_ipd);
    DQ11_nwv <= To_UX01(DQ11_ipd);
    DQ12_nwv <= To_UX01(DQ12_ipd);
    DQ13_nwv <= To_UX01(DQ13_ipd);
    DQ14_nwv <= To_UX01(DQ14_ipd);
    DQ15_nwv <= To_UX01(DQ15_ipd);
    DQ16_nwv <= To_UX01(DQ16_ipd);
    DQ17_nwv <= To_UX01(DQ17_ipd);
    DQ18_nwv <= To_UX01(DQ18_ipd);
    DQ19_nwv <= To_UX01(DQ19_ipd);
    DQ20_nwv <= To_UX01(DQ20_ipd);
    DQ21_nwv <= To_UX01(DQ21_ipd);
    DQ22_nwv <= To_UX01(DQ22_ipd);
    DQ23_nwv <= To_UX01(DQ23_ipd);
    DQ24_nwv <= To_UX01(DQ24_ipd);
    DQ25_nwv <= To_UX01(DQ25_ipd);
    DQ26_nwv <= To_UX01(DQ26_ipd);
    DQ27_nwv <= To_UX01(DQ27_ipd);
    DQ28_nwv <= To_UX01(DQ28_ipd);
    DQ29_nwv <= To_UX01(DQ29_ipd);
    DQ30_nwv <= To_UX01(DQ30_ipd);
    DQ31_nwv <= To_UX01(DQ31_ipd);
    A0_nwv  <= To_UX01(A0_ipd);
    A1_nwv  <= To_UX01(A1_ipd);
    A2_nwv  <= To_UX01(A2_ipd);
    A3_nwv  <= To_UX01(A3_ipd);
    A4_nwv  <= To_UX01(A4_ipd);
    A5_nwv  <= To_UX01(A5_ipd);
    A6_nwv  <= To_UX01(A6_ipd);
    A7_nwv  <= To_UX01(A7_ipd);
    A8_nwv  <= To_UX01(A8_ipd);
    A9_nwv  <= To_UX01(A9_ipd);
    A10_nwv <= To_UX01(A10_ipd);
    A11_nwv <= To_UX01(A11_ipd);

    ---------------------------------------------------------------------------
    -- Main Behavior Block
    ---------------------------------------------------------------------------
    Main : BLOCK

        PORT (
            BAIn      : IN   std_logic_vector(1 downto 0);
            DQM0In    : IN   std_ulogic := 'X';
            DQM1In    : IN   std_ulogic := 'X';
            DQM2In    : IN   std_ulogic := 'X';
            DQM3In    : IN   std_ulogic := 'X';
            DataIn    : IN   std_logic_vector(31 downto 0);
            DataOut   : OUT  std_logic_vector(31 downto 0) := (others => 'Z');
            CLKIn     : IN   std_ulogic := 'X';
            CKEIn     : IN   std_ulogic := 'X';
            AddressIn : IN   std_logic_vector(11 downto 0);
            WENegIn   : IN   std_ulogic := 'X';
            RASNegIn  : IN   std_ulogic := 'X';
            CSNegIn   : IN   std_ulogic := 'X';
            CASNegIn  : IN   std_ulogic := 'X'
        );
        PORT MAP (
            BAIn(0)     => BA0_nwv,
            BAIn(1)     => BA1_nwv,
            DQM3In      => DQM3_nwv,
            DQM2In      => DQM2_nwv,
            DQM1In      => DQM1_nwv,
            DQM0In      => DQM0_nwv,
            DataOut(0)  =>  DQ0,
            DataOut(1)  =>  DQ1,
            DataOut(2)  =>  DQ2,
            DataOut(3)  =>  DQ3,
            DataOut(4)  =>  DQ4,
            DataOut(5)  =>  DQ5,
            DataOut(6)  =>  DQ6,
            DataOut(7)  =>  DQ7,
            DataOut(8)  =>  DQ8,
            DataOut(9)  =>  DQ9,
            DataOut(10) =>  DQ10,
            DataOut(11) =>  DQ11,
            DataOut(12) =>  DQ12,
            DataOut(13) =>  DQ13,
            DataOut(14) =>  DQ14,
            DataOut(15) =>  DQ15,
            DataOut(16) =>  DQ16,
            DataOut(17) =>  DQ17,
            DataOut(18) =>  DQ18,
            DataOut(19) =>  DQ19,
            DataOut(20) =>  DQ20,
            DataOut(21) =>  DQ21,
            DataOut(22) =>  DQ22,
            DataOut(23) =>  DQ23,
            DataOut(24) =>  DQ24,
            DataOut(25) =>  DQ25,
            DataOut(26) =>  DQ26,
            DataOut(27) =>  DQ27,
            DataOut(28) =>  DQ28,
            DataOut(29) =>  DQ29,
            DataOut(30) =>  DQ30,
            DataOut(31) =>  DQ31,
            DataIn(0)   =>  DQ0_nwv,
            DataIn(1)   =>  DQ1_nwv,
            DataIn(2)   =>  DQ2_nwv,
            DataIn(3)   =>  DQ3_nwv,
            DataIn(4)   =>  DQ4_nwv,
            DataIn(5)   =>  DQ5_nwv,
            DataIn(6)   =>  DQ6_nwv,
            DataIn(7)   =>  DQ7_nwv,
            DataIn(8)   =>  DQ8_nwv,
            DataIn(9)   =>  DQ9_nwv,
            DataIn(10)  =>  DQ10_nwv,
            DataIn(11)  =>  DQ11_nwv,
            DataIn(12)  =>  DQ12_nwv,
            DataIn(13)  =>  DQ13_nwv,
            DataIn(14)  =>  DQ14_nwv,
            DataIn(15)  =>  DQ15_nwv,
            DataIn(16)    =>  DQ16_nwv,
            DataIn(17)    =>  DQ17_nwv,
            DataIn(18)    =>  DQ18_nwv,
            DataIn(19)    =>  DQ19_nwv,
            DataIn(20)    =>  DQ20_nwv,
            DataIn(21)    =>  DQ21_nwv,
            DataIn(22)    =>  DQ22_nwv,
            DataIn(23)    =>  DQ23_nwv,
            DataIn(24)    =>  DQ24_nwv,
            DataIn(25)    =>  DQ25_nwv,
            DataIn(26)    =>  DQ26_nwv,
            DataIn(27)    =>  DQ27_nwv,
            DataIn(28)    =>  DQ28_nwv,
            DataIn(29)    =>  DQ29_nwv,
            DataIn(30)    =>  DQ30_nwv,
            DataIn(31)    =>  DQ31_nwv,
            CLKIn        => CLK_nwv,
            CKEIn        => CKE_nwv,
            AddressIn(0) => A0_nwv,
            AddressIn(1) => A1_nwv,
            AddressIn(2) => A2_nwv,
            AddressIn(3) => A3_nwv,
            AddressIn(4) => A4_nwv,
            AddressIn(5) => A5_nwv,
            AddressIn(6) => A6_nwv,
            AddressIn(7) => A7_nwv,
            AddressIn(8) => A8_nwv,
            AddressIn(9) => A9_nwv,
            AddressIn(10) => A10_nwv,
            AddressIn(11) => A11_nwv,
            WENegIn  => WENeg_nwv,
            RASNegIn => RASNeg_nwv,
            CSNegIn  => CSNeg_nwv,
            CASNegIn => CASNeg_nwv
        );

        -- Type definition for state machine
        TYPE mem_state IS (
                        pwron,
                        precharge,
                        idle,
                        mode_set,
                        self_refresh,
                        auto_refresh,
                        pwrdwn,
                        bank_act,
                        bank_act_pwrdwn,
                        write,
                        write_suspend,
                        read,
                        read_suspend,
                        write_auto_pre,
                        read_auto_pre
                        );

        TYPE statebanktype IS array (hi_bank downto 0) of mem_state;

        SIGNAL statebank : statebanktype;

        SIGNAL CAS_Lat  : NATURAL RANGE 0 to 3 := 0;
        SIGNAL D_zd     : std_logic_vector(31 DOWNTO 0);

         -- Memory array declaration
        TYPE MemStore IS ARRAY(0 to 4*depth-1) OF INTEGER RANGE -2 TO 16#FF#;

        TYPE MemBlock   IS ARRAY (0 to 3) OF MemStore;
        SHARED VARIABLE Mem : MemBlock;
        SHARED VARIABLE DataDrive  : std_logic_vector(31 DOWNTO 0);

    BEGIN

        PoweredUp <= false, true after tpowerup;

    ---------------------------------------------------------------------------
    -- Main Behavior Process
    ---------------------------------------------------------------------------
    Behavior : PROCESS (BAIn, DQM0In, DQM1In, DQM2In, DQM3In, DataIn, CLKIn,
                        CKEIn, AddressIn, WENegIn, RASNegIn, CSNegIn,
                        CASNegIn, PoweredUp)

    -- Timing Check Variables
    VARIABLE Tviol_BA_CLK       : X01 := '0';
    VARIABLE TD_BA_CLK          : VitalTimingDataType;

    VARIABLE Tviol_DQM0_CLK     : X01 := '0';
    VARIABLE TD_DQM0_CLK        : VitalTimingDataType;

    VARIABLE Tviol_DQM1_CLK     : X01 := '0';
    VARIABLE TD_DQM1_CLK        : VitalTimingDataType;

    VARIABLE Tviol_DQM2_CLK     : X01 := '0';
    VARIABLE TD_DQM2_CLK        : VitalTimingDataType;

    VARIABLE Tviol_DQM3_CLK     : X01 := '0';
    VARIABLE TD_DQM3_CLK        : VitalTimingDataType;

    VARIABLE Tviol_D0_CLK       : X01 := '0';
    VARIABLE TD_D0_CLK          : VitalTimingDataType;

    VARIABLE Tviol_CKE_CLK      : X01 := '0';
    VARIABLE TD_CKE_CLK         : VitalTimingDataType;

    VARIABLE Tviol_Address_CLK  : X01 := '0';
    VARIABLE TD_Address_CLK     : VitalTimingDataType;

    VARIABLE Tviol_WENeg_CLK    : X01 := '0';
    VARIABLE TD_WENeg_CLK       : VitalTimingDataType;

    VARIABLE Tviol_RASNeg_CLK   : X01 := '0';
    VARIABLE TD_RASNeg_CLK      : VitalTimingDataType;

    VARIABLE Tviol_CSNeg_CLK    : X01 := '0';
    VARIABLE TD_CSNeg_CLK       : VitalTimingDataType;

    VARIABLE Tviol_CASNeg_CLK   : X01 := '0';
    VARIABLE TD_CASNeg_CLK      : VitalTimingDataType;

    VARIABLE Pviol0_CLK  : X01 := '0';
    VARIABLE PD0_CLK     : VitalPeriodDataType := VitalPeriodDataInit;

    VARIABLE Pviol1_CLK  : X01 := '0';
    VARIABLE PD1_CLK     : VitalPeriodDataType := VitalPeriodDataInit;

    VARIABLE Pviol2_CLK  : X01 := '0';
    VARIABLE PD2_CLK     : VitalPeriodDataType := VitalPeriodDataInit;

    -- Type definition for commands
    TYPE command_type is (
                        desl,
                        nop,
                        bst,
                        read,
                        writ,
                        act,
                        pre,
                        mrs,
                        ref
                        );

    TYPE Burst_type IS (sequential, interleave);
    TYPE Write_Burst_type IS (programmed, single);
    TYPE sequence       IS ARRAY (0 to 7) OF NATURAL RANGE 0 to 7;
    TYPE seqtab         IS ARRAY (0 to 7) OF sequence;
    TYPE MemLoc         IS ARRAY (0 to 3) OF std_logic_vector(19 DOWNTO 0);
    TYPE burst_counter  IS ARRAY (0 to 3) OF NATURAL RANGE 0 to 257;
    TYPE StartAddr_type IS ARRAY (0 to 3) OF NATURAL RANGE 0 TO 7;
    TYPE BurstInc_type  IS ARRAY (0 to 3) OF NATURAL RANGE 0 TO 255;
    TYPE BaseLoc_type   IS ARRAY (0 to 3) OF NATURAL RANGE 0 TO depth;

    CONSTANT seq0 : sequence := (0 & 1 & 2 & 3 & 4 & 5 & 6 & 7);
    CONSTANT seq1 : sequence := (1 & 0 & 3 & 2 & 5 & 4 & 7 & 6);
    CONSTANT seq2 : sequence := (2 & 3 & 0 & 1 & 6 & 7 & 4 & 5);
    CONSTANT seq3 : sequence := (3 & 2 & 1 & 0 & 7 & 6 & 5 & 4);
    CONSTANT seq4 : sequence := (4 & 5 & 6 & 7 & 0 & 1 & 2 & 3);
    CONSTANT seq5 : sequence := (5 & 4 & 7 & 6 & 1 & 0 & 3 & 2);
    CONSTANT seq6 : sequence := (6 & 7 & 4 & 5 & 2 & 3 & 0 & 1);
    CONSTANT seq7 : sequence := (7 & 6 & 5 & 4 & 3 & 2 & 1 & 0);
    CONSTANT intab : seqtab :=(seq0, seq1, seq2, seq3, seq4, seq5, seq6, seq7);

    FILE mem_file       : text IS mem_file_name;
    VARIABLE file_bank  : NATURAL := 0;
    VARIABLE ind        : NATURAL := 0;
    VARIABLE buf        : line;

    VARIABLE MemAddr     : MemLoc;
    VARIABLE Loc         : NATURAL RANGE 0 TO 4*depth := 0;
    VARIABLE BaseLoc     : BaseLoc_type;
    VARIABLE BurstInc    : BurstInc_type;
    VARIABLE StartAddr   : StartAddr_type;

    VARIABLE BurstLen    : NATURAL RANGE 0 TO 256 := 0;
    VARIABLE Burst_Bits  : NATURAL RANGE 0 TO 7   := 0;
    VARIABLE Burst       : Burst_Type;
    VARIABLE WB          : Write_Burst_Type;
    VARIABLE BurstCnt    : burst_counter;

    VARIABLE command   : command_type;
    VARIABLE written   : boolean := false;
    VARIABLE chip_en   : boolean := false;

    VARIABLE cur_bank  : natural range 0 to hi_bank;
    VARIABLE ModeReg      : std_logic_vector(11 DOWNTO 0) := (OTHERS => 'X');
    VARIABLE Ref_Cnt      : NATURAL RANGE 0 TO 4096 := 0;
    VARIABLE Next_Ref     : TIME;
    VARIABLE BankString   : STRING(8 DOWNTO 1) := " Bank-X ";

    -- Functionality Results Variables
    VARIABLE Violation     : X01 := '0';
    VARIABLE DataDriveOut  :  std_logic_vector(31 DOWNTO 0) := (OTHERS => 'Z');
    SUBTYPE OutWord   IS std_logic_vector(31 DOWNTO 0);
    VARIABLE DataDrive1 : OutWord;
    VARIABLE DataDrive2 : OutWord;
    VARIABLE DataDrive3 : OutWord;
    VARIABLE DQM0_reg0  : UX01;
    VARIABLE DQM0_reg1  : UX01;
    VARIABLE DQM0_reg2  : UX01;
    VARIABLE DQM1_reg0  : UX01;
    VARIABLE DQM1_reg1  : UX01;
    VARIABLE DQM1_reg2  : UX01;
    VARIABLE DQM2_reg0  : UX01;
    VARIABLE DQM2_reg1  : UX01;
    VARIABLE DQM2_reg2  : UX01;
    VARIABLE DQM3_reg0  : UX01;
    VARIABLE DQM3_reg1  : UX01;
    VARIABLE DQM3_reg2  : UX01;
    VARIABLE report_err : BOOLEAN := FALSE;
    VARIABLE line       : NATURAL := 0;

    PROCEDURE generate_out
    (Bank  :   IN  NATURAL )
    IS
    BEGIN
        DataDrive(7 downto 0) := (others => 'U');
        IF Mem(Bank)(Loc) > -2 THEN
            DataDrive(7 downto 0) := (others => 'X');
        END IF;
        IF Mem(Bank)(Loc) > -1 THEN
            DataDrive(7 downto 0) := to_slv(Mem(Bank)(Loc),8);
        END IF;

        DataDrive(15 downto 8) := (others => 'U');
        IF Mem(Bank)(Loc+1) > -2 THEN
            DataDrive(15 downto 8) := (others => 'X');
        END IF;
        IF Mem(Bank)(Loc+1) > -1 THEN
            DataDrive(15 downto 8) := to_slv(Mem(Bank)(Loc+1),8);
        END IF;

        DataDrive(23 downto 16) := (others => 'U');
        IF Mem(Bank)(Loc+2) > -2 THEN
            DataDrive(23 downto 16) := (others => 'X');
        END IF;
        IF Mem(Bank)(Loc+2) > -1 THEN
            DataDrive(23 downto 16) := to_slv(Mem(Bank)(Loc+2),8);
        END IF;

        DataDrive(31 downto 24) := (others => 'U');
        IF Mem(Bank)(Loc+3) > -2 THEN
            DataDrive(31 downto 24) := (others => 'X');
        END IF;
        IF Mem(Bank)(Loc+3) > -1 THEN
            DataDrive(31 downto 24) := to_slv(Mem(Bank)(Loc+3),8);
        END IF;

    END PROCEDURE generate_out;

    PROCEDURE MemWrite
    (Bank  :   IN  NATURAL )
    IS
    BEGIN
        IF (DQM0_nwv = '0') THEN
            Mem(Bank)(Loc) := -1;
            IF Violation = '0' THEN
                Mem(Bank)(Loc) := to_nat(DataIn(7 downto 0));
            END IF;
        END IF;
        IF (DQM1_nwv = '0') THEN
            Mem(Bank)(Loc+1) := -1;
            IF Violation = '0' THEN
                Mem(Bank)(Loc+1) := to_nat(DataIn(15 downto 8));
            END IF;
        END IF;
        IF (DQM2_nwv = '0') THEN
            Mem(Bank)(Loc+2) := -1;
            IF Violation = '0' THEN
                Mem(Bank)(Loc+2) := to_nat(DataIn(23 downto 16));
            END IF;
        END IF;
        IF (DQM3_nwv = '0') THEN
            Mem(Bank)(Loc+3) := -1;
            IF Violation = '0' THEN
                Mem(Bank)(Loc+3) := to_nat(DataIn(31 downto 24));
            END IF;
        END IF;
    END PROCEDURE MemWrite;

    PROCEDURE BurstIncProc
    (Bank  :   IN  NATURAL )
    IS
    BEGIN
        BurstInc(bank) := 0;
        IF (Burst_Bits > 0) THEN
            BurstInc(bank) := to_nat(AddressIn(Burst_Bits-1 downto 0));
        END IF;
    END PROCEDURE BurstIncProc;

    PROCEDURE NextStateAuto
    (Bank  :   IN  NATURAL;
     state :   IN mem_state )
    IS
    BEGIN
        IF (AddressIn(10) = '0') THEN
            statebank(bank) <= state;
        ELSIF (AddressIn(10) = '1') THEN
            IF state = write THEN
                statebank(bank) <= write_auto_pre;
            ELSE
                statebank(bank) <= read_auto_pre;
            END IF;
        END IF;
    END PROCEDURE NextStateAuto;

    BEGIN
        --------------------------------------------------------------------
        -- Timing Check Section
        --------------------------------------------------------------------
        IF (TimingChecksOn) THEN

            VitalSetupHoldCheck (
                TestSignal      => BAIn,
                TestSignalName  => "BA",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_BA_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_BA_CLK );

            VitalSetupHoldCheck (
                TestSignal      => DQM0In,
                TestSignalName  => "DQM0",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_DQM0_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_DQM0_CLK );

            VitalSetupHoldCheck (
                TestSignal      => DQM1In,
                TestSignalName  => "DQM1",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_DQM1_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_DQM1_CLK );

            VitalSetupHoldCheck (
                TestSignal      => DQM2In,
                TestSignalName  => "DQM2",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_DQM2_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_DQM2_CLK );

            VitalSetupHoldCheck (
                TestSignal      => DQM3In,
                TestSignalName  => "DQM3",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_DQM3_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_DQM3_CLK );

            VitalSetupHoldCheck (
                TestSignal      => DataIn,
                TestSignalName  => "Data",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_D0_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_D0_CLK );

            VitalSetupHoldCheck (
                TestSignal      => CKEIn,
                TestSignalName  => "CKE",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => true,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_CKE_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_CKE_CLK );

            VitalSetupHoldCheck (
                TestSignal      => AddressIn,
                TestSignalName  => "Address",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_Address_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_Address_CLK );

            VitalSetupHoldCheck (
                TestSignal      => WENegIn,
                TestSignalName  => "WENeg",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_WENeg_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_WENeg_CLK );

            VitalSetupHoldCheck (
                TestSignal      => RASNegIn,
                TestSignalName  => "RASNeg",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_RASNeg_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_RASNeg_CLK );

            VitalSetupHoldCheck (
                TestSignal      => CSNegIn,
                TestSignalName  => "CSNeg",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_CSNeg_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_CSNeg_CLK );

            VitalSetupHoldCheck (
                TestSignal      => CASNegIn,
                TestSignalName  => "CASNeg",
                RefSignal       => CLKIn,
                RefSignalName   => "CLK",
                SetupHigh       => tsetup_DQ0_CLK,
                SetupLow        => tsetup_DQ0_CLK,
                HoldHigh        => thold_DQ0_CLK,
                HoldLow         => thold_DQ0_CLK,
                CheckEnabled    => chip_en,
                RefTransition   => '/',
                HeaderMsg       => InstancePath & PartID,
                TimingData      => TD_CASNeg_CLK,
                XOn             => XOn,
                MsgOn           => MsgOn,
                Violation       => Tviol_CASNeg_CLK );

            VitalPeriodPulseCheck (
                TestSignal      =>  CLKIn,
                TestSignalName  =>  "CLK",
                Period          =>  tperiod_CLK_cl0_eq_1_posedge,
                PulseWidthLow   =>  tpw_CLK_negedge,
                PulseWidthHigh  =>  tpw_CLK_posedge,
                PeriodData      =>  PD0_CLK,
                XOn             =>  XOn,
                MsgOn           =>  MsgOn,
                Violation       =>  Pviol0_CLK,
                HeaderMsg       =>  InstancePath & PartID,
                CheckEnabled    =>  ModeReg(6 downto 4) = "001" );

            VitalPeriodPulseCheck (
                TestSignal      =>  CLKIn,
                TestSignalName  =>  "CLK",
                Period          =>  tperiod_CLK_cl1_eq_1_posedge,
                PulseWidthLow   =>  tpw_CLK_negedge,
                PulseWidthHigh  =>  tpw_CLK_posedge,
                PeriodData      =>  PD1_CLK,
                XOn             =>  XOn,
                MsgOn           =>  MsgOn,
                Violation       =>  Pviol1_CLK,
                HeaderMsg       =>  InstancePath & PartID,
                CheckEnabled    =>  ModeReg(6 downto 4) = "010" );

            VitalPeriodPulseCheck (
                TestSignal      =>  CLKIn,
                TestSignalName  =>  "CLK",
                Period          =>  tperiod_CLK_cl2_eq_1_posedge,
                PulseWidthLow   =>  tpw_CLK_negedge,
                PulseWidthHigh  =>  tpw_CLK_posedge,
                PeriodData      =>  PD2_CLK,
                XOn             =>  XOn,
                MsgOn           =>  MsgOn,
                Violation       =>  Pviol2_CLK,
                HeaderMsg       =>  InstancePath & PartID,
                CheckEnabled    =>  ModeReg(6 downto 4) = "011" );

            Violation := Pviol0_CLK OR Pviol1_CLK OR Pviol2_CLK OR
                        Tviol_BA_CLK OR Tviol_DQM1_CLK OR
                        Tviol_DQM0_CLK OR Tviol_D0_CLK OR Tviol_CKE_CLK OR
                        Tviol_Address_CLK OR Tviol_WENeg_CLK OR
                        Tviol_DQM2_CLK OR Tviol_DQM3_CLK OR
                        Tviol_RASNeg_CLK OR Tviol_CSNeg_CLK OR
                        Tviol_CASNeg_CLK;

            ASSERT Violation = '0'
                REPORT InstancePath & partID & ": simulation may be" &
                        " inaccurate due to timing violations"
                SEVERITY SeverityMode;

        END IF; -- Timing Check Section

    --------------------------------------------------------------------
    -- Functional Section
    --------------------------------------------------------------------
    IF (rising_edge(CLKIn)) THEN
        CKEreg <= CKE_nwv;
        IF (NOW > Next_Ref AND PoweredUp AND Ref_Cnt > 0) THEN
            Ref_Cnt  := Ref_Cnt - 1;
            Next_Ref := NOW + tdevice_REF;
        END IF;
        IF CKEreg = '1' THEN
            IF CSNegIn = '0' THEN
                chip_en := true;
            ELSE
                chip_en := false;
            END IF;
        END IF;
    END IF;

    IF (rising_edge(CLKIn) AND CKEreg = '1' AND to_X01(CSNegIn) = '0') THEN
        ASSERT (not(Is_X(DQM0In)))
            REPORT InstancePath & partID & ": Unusable value for DQM0"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(DQM1In)))
            REPORT InstancePath & partID & ": Unusable value for DQM1"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(DQM2In)))
            REPORT InstancePath & partID & ": Unusable value for DQM2"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(DQM3In)))
            REPORT InstancePath & partID & ": Unusable value for DQM3"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(WENegIn)))
            REPORT InstancePath & partID & ": Unusable value for WENeg"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(RASNegIn)))
            REPORT InstancePath & partID & ": Unusable value for RASNeg"
            SEVERITY SeverityMode;
        ASSERT (not(Is_X(CASNegIn)))
            REPORT InstancePath & partID & ": Unusable value for CASNeg"
            SEVERITY SeverityMode;

        -- Command Decode
        IF ((RASNegIn = '1') AND (CASNegIn = '1') AND (WENegIn = '1')) THEN
            command := nop;
        ELSIF ((RASNegIn = '0') AND (CASNegIn = '1') AND (WENegIn = '1')) THEN
            command := act;
        ELSIF ((RASNegIn = '1') AND (CASNegIn = '0') AND (WENegIn = '1')) THEN
            command := read;
        ELSIF ((RASNegIn = '1') AND (CASNegIn = '0') AND (WENegIn = '0')) THEN
            command := writ;
        ELSIF ((RASNegIn = '1') AND (CASNegIn = '1') AND (WENegIn = '0')) THEN
            command := bst;
        ELSIF ((RASNegIn = '0') AND (CASNegIn = '1') AND (WENegIn = '0')) THEN
            command := pre;
        ELSIF ((RASNegIn = '0') AND (CASNegIn = '0') AND (WENegIn = '1')) THEN
            command := ref;
        ELSIF ((RASNegIn = '0') AND (CASNegIn = '0') AND (WENegIn = '0')) THEN
            command := mrs;
        END IF;

        -- PowerUp Check
        IF (NOT(PoweredUp) AND command /= nop) THEN
            ASSERT false
                REPORT InstancePath & partID & ": Incorrect power up. Command"
                        & " issued before power up complete."
                SEVERITY SeverityMode;
        END IF;

        -- Bank Decode
        CASE BAIn IS
            WHEN "00" => cur_bank := 0; BankString := " Bank-0 ";
            WHEN "01" => cur_bank := 1; BankString := " Bank-1 ";
            WHEN "10" => cur_bank := 2; BankString := " Bank-2 ";
            WHEN "11" => cur_bank := 3; BankString := " Bank-3 ";
            WHEN others =>
                ASSERT false
                    REPORT InstancePath & partID & ": Could not decode bank"
                        & " selection - results may be incorrect."
                    SEVERITY SeverityMode;
        END CASE;
    END IF;

    -- The Big State Machine
    IF (rising_edge(CLKIn) AND CKEreg = '1') THEN

        ASSERT (not(Is_X(CSNegIn)))
            REPORT InstancePath & partID & ": Unusable value for CSNeg"
            SEVERITY SeverityMode;

        IF (CSNegIn = '1') THEN
            command := nop;
        END IF;

        -- DQM pipeline
        DQM0_reg2 := DQM0_reg1;
        DQM0_reg1 := DQM0_reg0;
        DQM0_reg0 := DQM0In;
        DQM1_reg2 := DQM1_reg1;
        DQM1_reg1 := DQM1_reg0;
        DQM1_reg0 := DQM1In;
        DQM2_reg2 := DQM2_reg1;
        DQM2_reg1 := DQM2_reg0;
        DQM2_reg0 := DQM2In;
        DQM3_reg2 := DQM3_reg1;
        DQM3_reg1 := DQM3_reg0;
        DQM3_reg0 := DQM3In;

        -- by default data drive is Z, might get over written in one
        -- of the passes below
        DataDrive := (OTHERS => 'Z');

        banks : FOR bank IN 0 TO hi_bank LOOP
        CASE statebank(bank) IS
        WHEN pwron =>
            ASSERT (DQM0In = '1')
                REPORT InstancePath & partID & BankString
                    &": DQM0 must be held high"
                    &" during initialization."
                SEVERITY SeverityMode;

            ASSERT (DQM1In = '1')
                REPORT InstancePath & partID & BankString
                    &": DQM1 must be held high"
                    & " during initialization."
                SEVERITY SeverityMode;

            ASSERT (DQM2In = '1')
                REPORT InstancePath & partID & BankString
                    &": DQM2 must be held high"
                    &" during initialization."
                SEVERITY SeverityMode;

            ASSERT (DQM3In = '1')
                REPORT InstancePath & partID & BankString
                    &": DQM3 must be held high"
                    & " during initialization."
                SEVERITY SeverityMode;

            IF (PoweredUp = false) THEN
                ASSERT (command = nop)
                    REPORT InstancePath & partID & BankString
                        &": Only NOPs allowed"
                        & " during power up."
                    SEVERITY SeverityMode;
                DataDrive := "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
            ELSIF (command = pre) AND ((cur_bank = bank) OR
                    (AddressIn(10) = '1')) THEN
                statebank(bank) <= precharge, idle AFTER tdevice_TRP;
            END IF;

        WHEN precharge =>
            IF cur_bank = bank THEN
                -- It is only an error if this bank is selected
                ASSERT (command = nop OR command = pre)
                    REPORT InstancePath & partID & BankString
                            &": Illegal command received"
                            & " during precharge."
                    SEVERITY SeverityMode;
            END IF;

        WHEN idle =>
            IF (command = nop OR command = bst OR command = pre) OR
                (cur_bank /= bank) THEN
                null;
            ELSIF (command = mrs) THEN
                IF (statebank = idle & idle & idle & idle) THEN
                    ModeReg := AddressIn;
                    statebank <= mode_set & mode_set & mode_set & mode_set;
                END IF;
            ELSIF (command = ref) THEN
                IF (statebank = idle & idle & idle & idle) THEN
                    IF (CKEIn = '1') THEN
                        statebank(bank) <= auto_refresh, idle  AFTER
                            tdevice_TRCAR;
                    ELSE
                        statebank <= self_refresh & self_refresh
                                & self_refresh & self_refresh;
                    END IF;
                END IF;
            ELSIF (command = act) THEN
                statebank(bank) <= bank_act;
                ras_in(bank)  <= '1', '0' AFTER 70 ns;
                rct_in  <= '1', '0' AFTER 1 ns;
                rcdt_in(bank) <= '1', '0' AFTER 1 ns;
                MemAddr(bank)(19 downto 8) := AddressIn;  -- latch row addr
            ELSE
                ASSERT false
                    REPORT InstancePath & partID & ": Illegal command"
                            & " received in idle state."
                    SEVERITY SeverityMode;
            END IF;

        WHEN mode_set =>
            statebank <= idle & idle & idle & idle;
            ASSERT (ModeReg(7) = '0' AND ModeReg(8) ='0')
                REPORT InstancePath & partID & BankString
                        &": Illegal operating mode set."
                SEVERITY SeverityMode;
            ASSERT command = nop
                REPORT InstancePath & partID & BankString
                        & ": Illegal command received during mode_set."
                SEVERITY SeverityMode;
            -- read burst length
            IF (ModeReg(2 downto 0) = "000") THEN
                BurstLen := 1;
                Burst_Bits := 0;
            ELSIF (ModeReg(2 downto 0) = "001") THEN
                BurstLen := 2;
                Burst_Bits := 1;
            ELSIF (ModeReg(2 downto 0) = "010") THEN
                BurstLen := 4;
                Burst_Bits := 2;
            ELSIF (ModeReg(2 downto 0) = "011") THEN
                BurstLen := 8;
                Burst_Bits := 3;
            ELSIF (ModeReg(2 downto 0) = "111") THEN
                BurstLen := 256;
                Burst_Bits := 7;
            ELSE
                ASSERT false
                    REPORT InstancePath & partID & BankString
                            &": Invalid burst length specified."
                    SEVERITY SeverityMode;
            END IF;
            -- read burst type
            IF (ModeReg(3) = '0') THEN
                Burst := sequential;
            ELSIF (ModeReg(3) = '1') THEN
                Burst := interleave;
            ELSE
                ASSERT false
                    REPORT InstancePath & partID & BankString
                            &": Invalid burst type specified."
                    SEVERITY SeverityMode;
            END IF;
            -- read CAS latency
            IF (ModeReg(6 downto 4) = "001") THEN
                CAS_Lat <= 1;
            ELSIF (ModeReg(6 downto 4) = "010") THEN
                CAS_Lat <= 2;
            ELSIF (ModeReg(6 downto 4) = "011") THEN
                CAS_Lat <= 3;
            ELSE
                ASSERT false
                REPORT InstancePath & partID & BankString &
                    ": CAS Latency set incorrecty "
                SEVERITY SeverityMode;
            END IF;
            -- read write burst mode
            IF (ModeReg(9) = '0') THEN
                WB := programmed;
            ELSIF (ModeReg(9) = '1') THEN
                WB := single;
            ELSE
                ASSERT false
                    REPORT InstancePath & partID & BankString &
                            ": Invalid burst type specified."
                    SEVERITY SeverityMode;
            END IF;

        WHEN auto_refresh =>
            IF (Ref_Cnt < 4096) THEN
                Ref_Cnt := Ref_Cnt + 1;
            END IF;
            ASSERT command = nop
                REPORT InstancePath & partID & BankString &
                        ": Illegal command received during auto_refresh."
                SEVERITY SeverityMode;

        WHEN bank_act =>
            IF (command = pre) AND ((cur_bank = bank) OR (AddressIn(10) = '1'))
                THEN
                ASSERT ras_out(bank) = '1'
                    REPORT InstancePath & partID & BankString &
                            ": precharge command"
                            & " does not meet tRAS time."
                    SEVERITY SeverityMode;
                statebank(bank) <= precharge, idle AFTER tdevice_TRP;
            ELSIF (command = nop OR command = bst) OR (cur_bank /= bank) THEN
                null;
            ELSIF (command = read) THEN
                ASSERT rcdt_out(bank) = '0'
                    REPORT InstancePath & partID & BankString &
                            ": read command received too soon after active."
                    SEVERITY SeverityMode;
                ASSERT ((AddressIn(10) = '0') OR (AddressIn(10) = '1'))
                    REPORT InstancePath & partID & BankString &
                            ": AddressIn(10) = X"
                            & " during read command. Next state unknown."
                    SEVERITY SeverityMode;
                MemAddr(bank)(7 downto 0) := (others => '0'); -- clr old addr

                BurstIncProc(Bank);

                MemAddr(bank)(7 downto Burst_Bits) :=
                            AddressIn(7 downto Burst_Bits); --latch col addr
                StartAddr(bank) := BurstInc(bank) mod 8;
                BaseLoc(bank) := to_nat(MemAddr(bank));
                Loc := 4*(BaseLoc(bank) + BurstInc(bank));

                generate_out(Bank);

                BurstCnt(bank) := 1;
                NextStateAuto(Bank,read);
            ELSIF (command = writ) THEN
                ASSERT rcdt_out(bank) = '0'
                    REPORT InstancePath & partID & BankString &
                            ": write command"
                            & " received too soon after active."
                    SEVERITY SeverityMode;
                ASSERT ((AddressIn(10) = '0') OR (AddressIn(10) = '1'))
                    REPORT InstancePath & partID & BankString &
                            ": AddressIn(10) = X"
                            & " during write command. Next state unknown."
                    SEVERITY SeverityMode;
                MemAddr(bank)(7 downto 0) := (others => '0'); -- clr old addr

                BurstIncProc(Bank);

                MemAddr(bank)(7 downto Burst_Bits) :=
                            AddressIn(7 downto Burst_Bits); --latch col addr

                StartAddr(bank) := BurstInc(bank) mod 8;
                BaseLoc(bank) := to_nat(MemAddr(bank));
                Loc := 4*(BaseLoc(bank) + BurstInc(bank));
                MemWrite(Bank);
                BurstCnt(bank) := 1;
                wrt_in <= '1';
                NextStateAuto(Bank,write);
                written := true;

            ELSIF (cur_bank = bank) OR (command = mrs) THEN
                ASSERT false
                    REPORT InstancePath & partID & BankString &
                            ": Illegal command "
                            & "received in active state."
                    SEVERITY SeverityMode;
            END IF;

        WHEN write =>
            IF (command = bst) THEN
                statebank(bank) <= bank_act;
                BurstCnt(bank) := 0;
            ELSIF (command = read) THEN
                IF (bank = cur_bank) THEN
                    MemAddr(bank)(7 downto 0):= (others => '0');-- clr old addr

                    BurstIncProc(Bank);

                    MemAddr(bank)(7 downto Burst_Bits) :=
                            AddressIn(7 downto Burst_Bits); --latch col addr

                    StartAddr(bank) := BurstInc(bank) mod 8;
                    BaseLoc(bank) := to_nat(MemAddr(bank));
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));

                    generate_out(Bank);

                    BurstCnt(bank) := 1;
                    NextStateAuto(Bank,read);
                ELSE
                    statebank(bank) <= bank_act;
                END IF;
            ELSIF (command = writ) THEN
                IF cur_bank = bank THEN
                    MemAddr(bank)(7 downto 0):=(others => '0');-- clr old addr

                    BurstIncProc(Bank);

                    MemAddr(bank)(7 downto Burst_Bits) :=
                            AddressIn(7 downto Burst_Bits); --latch col addr

                    StartAddr(bank) := BurstInc(bank) mod 8;
                    BaseLoc(bank) := to_nat(MemAddr(bank));
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));
                    MemWrite(Bank);
                    BurstCnt(bank) := 1;
                    wrt_in <= '1';
                    IF (AddressIn(10) = '1') THEN
                        statebank(bank) <= write_auto_pre;
                    END IF;
                ELSE
                    statebank(bank) <= bank_act;
                END IF;
            ELSIF (command = pre) AND ((cur_bank = bank) OR
                                (AddressIn(10) = '1')) THEN
                ASSERT ras_out(bank) = '1'
                    REPORT InstancePath & partID & BankString &
                            ": precharge command"
                            & " does not meet tRAS time."
                    SEVERITY SeverityMode;
                ASSERT (DQM0_nwv = '1')
                    REPORT InstancePath & partID & BankString &
                            ": DQM0 should be"
                            & " held high, data is lost."
                    SEVERITY SeverityMode;
                ASSERT (DQM1_nwv = '1')
                    REPORT InstancePath & partID & BankString &
                            ": DQM1 should be"
                            & " held high, data is lost."
                    SEVERITY SeverityMode;
               ASSERT (DQM2_nwv = '1')
                    REPORT InstancePath & partID & BankString &
                            ": DQM2 should be"
                            & " held high, data is lost."
                    SEVERITY SeverityMode;
                ASSERT (DQM3_nwv = '1')
                    REPORT InstancePath & partID & BankString &
                            ": DQM3 should be"
                            & " held high, data is lost."
                    SEVERITY SeverityMode;
                    wrt_in <= '0';
                    statebank(bank) <= precharge, idle AFTER tdevice_TRP;
            ELSIF (command = nop) OR (cur_bank /= bank) THEN
                IF (BurstCnt(bank) = BurstLen OR WB = single) THEN
                    statebank(bank) <= bank_act;
                    BurstCnt(bank) := 0;
                    ras_in(bank) <= '1';
                ELSE
                    IF (Burst = sequential) THEN
                        BurstInc(bank) := (BurstInc(bank) + 1) MOD BurstLen;
                    ELSE
                        BurstInc(bank) := intab(StartAddr(bank))
                                                (BurstCnt(bank));
                    END IF;
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));
                    MemWrite(Bank);
                    BurstCnt(bank) := BurstCnt(bank) + 1;
                    wrt_in <= '1';
                END IF;
            ELSIF cur_bank = bank THEN
                ASSERT false
                    REPORT InstancePath & partID & ": Illegal command"
                            & " received in write state."
                    SEVERITY SeverityMode;
            END IF;

        WHEN read =>
            IF (command = bst) THEN
                statebank(bank) <= bank_act;
                BurstCnt(bank) := 0;
            ELSIF (command = read) THEN
                IF cur_bank = bank THEN
                    MemAddr(bank)(7 downto 0):= (others => '0');--clr old addr

                    BurstIncProc(Bank);

                    MemAddr(bank)(7 downto Burst_Bits) :=
                            AddressIn(7 downto Burst_Bits); --latch col addr

                    StartAddr(bank) := BurstInc(bank) mod 8;
                    BaseLoc(bank)   := to_nat(MemAddr(bank));
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));

                    generate_out(Bank);

                    BurstCnt(bank) := 1;
                    NextStateAuto(Bank,read);
                ELSE
                    statebank(bank) <= bank_act;
                END IF;
            ELSIF (command = writ) THEN
                IF cur_bank = bank THEN
                    ASSERT rcdt_out(bank) = '0'
                        REPORT InstancePath & partID & BankString &
                                ": write command"
                                & " received too soon after active."
                        SEVERITY SeverityMode;
                    ASSERT ((AddressIn(10) = '0') OR (AddressIn(10) = '1'))
                        REPORT InstancePath & partID & BankString &
                                ": AddressIn(10) = X"
                                & " during write command. Next state unknown."
                        SEVERITY SeverityMode;
                    MemAddr(bank)(7 downto 0):= (others => '0');-- clr old addr
                    MemAddr(bank)(7 downto Burst_Bits) :=
                            AddressIn(7 downto Burst_Bits); --latch col addr

                    BurstIncProc(Bank);

                    StartAddr(bank) := BurstInc(bank) mod 8;
                    BaseLoc(bank) := to_nat(MemAddr(bank));
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));
                    MemWrite(Bank);
                    BurstCnt(bank) := 1;
                    wrt_in <= '1';
                    NextStateAuto(Bank,write);
                ELSE
                    statebank(bank) <= bank_act;
                END IF;
            ELSIF (command = pre) AND ((cur_bank = bank) OR
                                        (AddressIn(10) = '1')) THEN
                statebank(bank) <= precharge, idle AFTER tdevice_TRP;
                ASSERT ras_out(bank) = '1'
                    REPORT InstancePath & partID & BankString &
                        ": precharge command"
                        & " does not meet tRAS time."
                    SEVERITY SeverityMode;
            ELSIF (command = nop) OR (cur_bank /= bank) THEN
                IF (BurstCnt(bank) = BurstLen) THEN
                    statebank(bank) <= bank_act;
                    BurstCnt(bank) := 0;
                    ras_in(bank) <= '1';
                ELSE
                    IF (Burst = sequential) THEN
                        BurstInc(bank):=(BurstInc(bank) + 1) MOD BurstLen;
                    ELSE
                        BurstInc(bank):= intab(StartAddr(bank))
                                                (BurstCnt(bank));
                    END IF;
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));
                    generate_out(Bank);
                    BurstCnt(bank) := BurstCnt(bank) + 1;
                END IF;
            ELSIF cur_bank = bank THEN
                ASSERT false
                    REPORT InstancePath & partID & BankString &
                            ": Illegal command"
                            & " received in read state."
                    SEVERITY SeverityMode;
            END IF;

        WHEN write_auto_pre =>
            IF (command = nop) OR (cur_bank /= bank) THEN
                IF (BurstCnt(bank) = BurstLen OR WB = single) THEN
                    statebank(bank) <= precharge, idle AFTER tdevice_TRP;
                    BurstCnt(bank) := 0;
                    ras_in(bank) <= '1';
                ELSE
                    IF (Burst = sequential) THEN
                        BurstInc(bank) := (BurstInc(bank) + 1) MOD BurstLen;
                    ELSE
                        BurstInc(bank) := intab(StartAddr(bank))
                                                (BurstCnt(bank));
                    END IF;
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));
                    MemWrite(Bank);
                    BurstCnt(bank) := BurstCnt(bank) + 1;
                    wrt_in <= '1';
                END IF;
            ELSE
                ASSERT false
                    REPORT InstancePath & partID & BankString &
                            ": Illegal command"
                            & " received in write state."
                    SEVERITY SeverityMode;
            END IF;

        WHEN read_auto_pre =>
            IF (command = nop) OR (cur_bank /= bank AND command /= read
            AND command /= writ) THEN
                IF (BurstCnt(bank) = BurstLen) THEN
                    statebank(bank) <= precharge, idle AFTER tdevice_TRP;
                    BurstCnt(bank) := 0;
                    ras_in(bank) <= '1';
                ELSE
                    IF (Burst = sequential) THEN
                        BurstInc(bank) := (BurstInc(bank) + 1) MOD BurstLen;
                    ELSE
                        BurstInc(bank) := intab(StartAddr(bank))
                                                (BurstCnt(bank));
                    END IF;
                    Loc := 4*(BaseLoc(bank) + BurstInc(bank));
                    generate_out(Bank);
                    BurstCnt(bank) := BurstCnt(bank) + 1;
                END IF;
            ELSIF (command = read OR command = writ)
            AND (cur_bank /= bank) THEN
                statebank(bank) <= precharge, idle AFTER tdevice_TRP;
            ELSE
                ASSERT false
                    REPORT InstancePath & partID & BankString &
                            ": Illegal command"
                            & " received in read state."
                    SEVERITY SeverityMode;
            END IF;
        WHEN others => null;
        END CASE;
        END LOOP banks;

        -- Check Refresh Status
        IF (written = true) THEN
            ASSERT Ref_Cnt > 0
                REPORT InstancePath & partID &
                        ": memory not refreshed (by ref_cnt)"
                SEVERITY SeverityMode;
        END IF;
    END IF;

    -- Latency adjustments and DQM read masking
    IF (rising_edge(CLKIn)) THEN
        IF (CKEreg = '1') THEN
            DataDrive3 := DataDrive2;
            DataDrive2 := DataDrive1;
            DataDrive1 := DataDrive;
        END IF;
        IF (DQM0_reg1 = '0') THEN
            IF (CAS_Lat = 3) THEN
                DataDriveOut(7 downto 0) := DataDrive3(7 downto 0);
            ELSIF (CAS_Lat = 2) THEN
                DataDriveOut(7 downto 0) := DataDrive2(7 downto 0);
            ELSE
                DataDriveOut(7 downto 0) := DataDrive1(7 downto 0);
            END IF;
        ELSE
            DataDriveOut(7 downto 0) := (others => 'Z');
        END IF;
        IF (DQM1_reg1 = '0') THEN
            IF (CAS_Lat = 3) THEN
                DataDriveOut(15 downto 8) := DataDrive3(15 downto 8);
            ELSIF (CAS_Lat = 2) THEN
                DataDriveOut(15 downto 8) := DataDrive2(15 downto 8);
            ELSE
                DataDriveOut(15 downto 8) := DataDrive1(15 downto 8);
            END IF;
        ELSE
            DataDriveOut(15 downto 8) := (others => 'Z');
        END IF;
        IF (DQM2_reg1 = '0') THEN
            IF (CAS_Lat = 3) THEN
                DataDriveOut(23 downto 16) := DataDrive3(23 downto 16);
            ELSIF (CAS_Lat = 2) THEN
                DataDriveOut(23 downto 16) := DataDrive2(23 downto 16);
            ELSE
                DataDriveOut(23 downto 16) := DataDrive1(23 downto 16);
            END IF;
        ELSE
            DataDriveOut(23 downto 16) := (others => 'Z');
        END IF;
        IF (DQM3_reg1 = '0') THEN
            IF (CAS_Lat = 3) THEN
                DataDriveOut(31 downto 24) := DataDrive3(31 downto 24);
            ELSIF (CAS_Lat = 2) THEN
                DataDriveOut(31 downto 24) := DataDrive2(31 downto 24);
            ELSE
                DataDriveOut(31 downto 24) := DataDrive1(31 downto 24);
            END IF;
        ELSE
            DataDriveOut(31 downto 24) := (others => 'Z');
        END IF;
    END IF;

    -- The Powering-down State Machine
    IF (rising_edge(CLKIn) AND CKEreg = '1' AND CKEIn = '0') THEN

        ASSERT (not(Is_X(CSNegIn)))
            REPORT InstancePath & partID & ": Unusable value for CSNeg"
            SEVERITY SeverityMode;

        IF (CSNegIn = '1') THEN
            command := nop;
        END IF;

        CASE statebank(cur_bank) IS
            WHEN idle =>
                IF (command = nop) THEN
                    statebank <= pwrdwn & pwrdwn & pwrdwn & pwrdwn;
                END IF;
            WHEN write =>
                statebank(cur_bank) <= write_suspend;
            WHEN read =>
                statebank(cur_bank) <= read_suspend;
            WHEN bank_act =>
                IF (command = writ) THEN
                    statebank(cur_bank) <= write_suspend;
                ELSIF (command = read) THEN
                    statebank(cur_bank) <= read_suspend;
                ELSE
                    statebank(cur_bank) <= bank_act_pwrdwn;
                END IF;
            WHEN others => null;
        END CASE;
    END IF;

    -- The Powering-up State Machine
    IF (rising_edge(CLKIn) AND CKEreg = '0' AND CKEIn = '1') THEN

        ASSERT (not(Is_X(CSNegIn)))
            REPORT InstancePath & partID & ": Unusable value for CSNeg"
            SEVERITY SeverityMode;

        IF (CSNegIn = '1') THEN
            command := nop;
        END IF;

        CASE statebank(cur_bank) IS
            WHEN write_suspend =>
                statebank(cur_bank) <= write;
            WHEN read_suspend =>
                statebank(cur_bank) <= read;
            WHEN self_refresh =>
                statebank <= idle & idle & idle & idle after tdevice_TRP;
                Ref_Cnt := 4096;
                ASSERT command = nop
                    REPORT InstancePath & partID & ": Illegal command received"
                            & " during self_refresh."
                    SEVERITY SeverityMode;
            WHEN pwrdwn =>
                statebank <= idle & idle & idle & idle;
            WHEN bank_act_pwrdwn =>
                statebank(cur_bank) <= bank_act;
            WHEN others => null;
        END CASE;
    END IF;

-------------------------------------------------------------------------------
-- File Read Section
-------------------------------------------------------------------------------
--   mt48lc4m32b2  memory byte preload file format
-------------------------------------------------------------------------------
-- / - comment
-- @bbbbbb - <bbbbbb> stands for address within file bank(from 0 to 4*depth)
--          - b is hexadecimal number
--          - first two bits address bank
--          - others bits address sdram that is byte organized
-- dd - <dd> is byte to be written at MemData(a)(bbbbbbb++)
--            (bbbbbbb is incremented at every load)
-- only first 1-7 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
-------------------------------------------------------------------------------
    IF NOW = 0 ns  and (mem_file_name /= "none") AND UserPreload THEN
        ind := 0;
        WHILE (not ENDFILE (mem_file)) LOOP
            READLINE (mem_file, buf);
            line := line +1;
            IF buf(1) = '/' THEN
                NEXT;
            ELSIF buf(1) = '@' THEN
                file_bank := h(buf(2 to 7)) /(4*depth);
                ind := h(buf(2 to 7)) mod (4*depth);
            ELSE
                IF (file_bank) <= 3 AND ind <= (4*depth-1) THEN
                   Mem(file_bank)(ind) := h(buf(1 to 2));
                   ind := (ind + 1);
                ELSE
                    IF report_err = FALSE THEN
                    ASSERT FALSE
                    REPORT "Memory file: " & mem_file_name &
                            " Address range error at line: "&to_int_Str(line)
                    SEVERITY error;
                    report_err := TRUE;
                    END IF;
                END IF;
            END IF;
        END LOOP;
    END IF;

    ---------------------------------------------------------------------------
    -- Output Section
    ---------------------------------------------------------------------------
    D_zd <= DataDriveOut;
    END PROCESS;

        -----------------------------------------------------------------------
        -- Path Delay Process
        -----------------------------------------------------------------------
        DataOutBlk : FOR i IN 31 DOWNTO 0 GENERATE
            DataOut_Delay : PROCESS (D_zd(i))
                VARIABLE D_GlitchData : VitalGlitchDataArrayType(31 Downto 0);
            BEGIN
                VitalPathDelay01Z (
                    OutSignal     => DataOut(i),
                    OutSignalName => "Data",
                    OutTemp       => D_zd(i),
                    Mode          => OnEvent,
                    GlitchData    => D_GlitchData(i),
                    Paths         => (
                        1 => (InputChangeTime => CLKIn'LAST_EVENT,
                                PathDelay     => tpd_CLK_DQ1,
                                PathCondition => CAS_Lat = 1),
                        2 => (InputChangeTime => CLKIn'LAST_EVENT,
                                PathDelay     => tpd_CLK_DQ2,
                                PathCondition => CAS_Lat = 2),
                        3 => (InputChangeTime => CLKIn'LAST_EVENT,
                                PathDelay     => tpd_CLK_DQ3,
                                PathCondition => CAS_Lat = 3)
                    )
                );
            END PROCESS;
        END GENERATE;
    END BLOCK;
END vhdl_behavioral;