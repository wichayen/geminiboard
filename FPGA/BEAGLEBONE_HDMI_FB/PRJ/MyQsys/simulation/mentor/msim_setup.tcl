
# (C) 2001-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 15.0 145 win32 2016.07.26.09:14:49

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "tb_PRJ_TOP"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/altera/15.0/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                  ./libraries/altera_ver/      
  vmap       altera_ver       ./libraries/altera_ver/      
  ensure_lib                  ./libraries/lpm_ver/         
  vmap       lpm_ver          ./libraries/lpm_ver/         
  ensure_lib                  ./libraries/sgate_ver/       
  vmap       sgate_ver        ./libraries/sgate_ver/       
  ensure_lib                  ./libraries/altera_mf_ver/   
  vmap       altera_mf_ver    ./libraries/altera_mf_ver/   
  ensure_lib                  ./libraries/altera_lnsim_ver/
  vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver/
  ensure_lib                  ./libraries/fiftyfivenm_ver/ 
  vmap       fiftyfivenm_ver  ./libraries/fiftyfivenm_ver/ 
  ensure_lib                  ./libraries/altera/          
  vmap       altera           ./libraries/altera/          
  ensure_lib                  ./libraries/lpm/             
  vmap       lpm              ./libraries/lpm/             
  ensure_lib                  ./libraries/sgate/           
  vmap       sgate            ./libraries/sgate/           
  ensure_lib                  ./libraries/altera_mf/       
  vmap       altera_mf        ./libraries/altera_mf/       
  ensure_lib                  ./libraries/altera_lnsim/    
  vmap       altera_lnsim     ./libraries/altera_lnsim/    
  ensure_lib                  ./libraries/fiftyfivenm/     
  vmap       fiftyfivenm      ./libraries/fiftyfivenm/     
}
ensure_lib                                        ./libraries/new_sdram_controller_0_s1_translator/  
vmap       new_sdram_controller_0_s1_translator   ./libraries/new_sdram_controller_0_s1_translator/  
ensure_lib                                        ./libraries/AvalonSimpleMaster_0_avm_m0_translator/
vmap       AvalonSimpleMaster_0_avm_m0_translator ./libraries/AvalonSimpleMaster_0_avm_m0_translator/
ensure_lib                                        ./libraries/rst_controller/                        
vmap       rst_controller                         ./libraries/rst_controller/                        
ensure_lib                                        ./libraries/mm_interconnect_0/                     
vmap       mm_interconnect_0                      ./libraries/mm_interconnect_0/                     
ensure_lib                                        ./libraries/new_sdram_controller_0/                
vmap       new_sdram_controller_0                 ./libraries/new_sdram_controller_0/                

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                 -work altera_ver      
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                          -work lpm_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                             -work sgate_ver       
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                         -work altera_mf_ver   
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv"     -work altera_lnsim_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/fiftyfivenm_atoms_for_vhdl.v" -work fiftyfivenm_ver 
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v"   -work fiftyfivenm_ver 
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"           -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"       -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"          -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"       -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd"    -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"               -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                         -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                        -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                      -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                           -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"            -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                       -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"         -work altera_lnsim    
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/fiftyfivenm_atoms.vhd"               -work fiftyfivenm     
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/fiftyfivenm_components.vhd"          -work fiftyfivenm     
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_slave_translator.sv"  -work new_sdram_controller_0_s1_translator  
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_master_translator.sv" -work AvalonSimpleMaster_0_avm_m0_translator
  vlog     "$QSYS_SIMDIR/submodules/mentor/altera_reset_controller.v"          -work rst_controller                        
  vlog     "$QSYS_SIMDIR/submodules/mentor/altera_reset_synchronizer.v"        -work rst_controller                        
  vcom     "$QSYS_SIMDIR/submodules/MyQsys_mm_interconnect_0.vhd"              -work mm_interconnect_0                     
  vcom     "$QSYS_SIMDIR/submodules/MyQsys_new_sdram_controller_0.vhd"         -work new_sdram_controller_0                
 
  
  vcom     "$QSYS_SIMDIR/../../ddio_out.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../FIFO.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../VGAFIFO.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../GPMCFIFO.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../pll_video_sd.vhd"                                                                                                                     
  
  
  vcom     "$QSYS_SIMDIR/../../../RTL/General_PKG.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/GPMC_IF.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/vga_syncgen.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/tmds_encoder.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/SYNC_GEN.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/pdiff_transmitter.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/FRAME_BUF.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/dvi_tx_pdiff.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/PRJ_TOP.vhd"                                                                                                                     
  
  
  
  vcom     "$QSYS_SIMDIR/../../../SIM/SIM_PKG.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/conversions.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/ecl_package.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/ecl_utils.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/ff_package.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/gen_utils.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/memory.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/mt48lc16m16a2.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/mt48lc8m16a2.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/state_tab_package.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/switch_pkg.vhd"                                                                                                                      
  vcom     "$QSYS_SIMDIR/../../../SIM/tb_PRJ_TOP.vhd"                                                                                                                     
  
  vcom     "$QSYS_SIMDIR/MyQsys.vhd"                                                                                                                     
  
  
}


alias my_com {
  echo "\[exec\] my_com"
 
  
  vcom     "$QSYS_SIMDIR/../../ddio_out.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../FIFO.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../VGAFIFO.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../GPMCFIFO.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../pll_video_sd.vhd"                                                                                                                     
  
  
  vcom     "$QSYS_SIMDIR/../../../RTL/General_PKG.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/GPMC_IF.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/vga_syncgen.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/tmds_encoder.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/SYNC_GEN.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/pdiff_transmitter.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/FRAME_BUF.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/dvi_tx_pdiff.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../RTL/PRJ_TOP.vhd"                                                                                                                     
  
  
  
  vcom     "$QSYS_SIMDIR/../../../SIM/SIM_PKG.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/conversions.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/ecl_package.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/ecl_utils.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/ff_package.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/gen_utils.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/memory.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/mt48lc8m16a2.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/state_tab_package.vhd"                                                                                                                     
  vcom     "$QSYS_SIMDIR/../../../SIM/Lib/switch_pkg.vhd"                                                                                                                      
  vcom     "$QSYS_SIMDIR/../../../SIM/tb_PRJ_TOP.vhd"                                                                                                                     
  
  vcom     "$QSYS_SIMDIR/MyQsys.vhd"                                                                                                                     
  
  
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work -L work_lib -L new_sdram_controller_0_s1_translator -L AvalonSimpleMaster_0_avm_m0_translator -L rst_controller -L mm_interconnect_0 -L new_sdram_controller_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -L work_lib -L new_sdram_controller_0_s1_translator -L AvalonSimpleMaster_0_avm_m0_translator -L rst_controller -L mm_interconnect_0 -L new_sdram_controller_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
