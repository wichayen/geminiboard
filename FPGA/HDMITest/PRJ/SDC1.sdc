# Clock constraints
create_clock -name "clk_in" -period 20.000ns [get_ports {clk_in}] -waveform {0.000 10.000}

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

