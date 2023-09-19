###############################################################################
## Copyright (C) 2021-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

create_clock -period "10.000 ns"  -name sys_clk_100mhz      [get_ports {sys_clk}]
create_clock -period  "4.000 ns"  -name ref_clk             [get_ports {fpga_refclk_in}]
create_clock -period  "4.000 ns"  -name device_clk          [get_ports {clkin6}]

derive_pll_clocks
derive_clock_uncertainty

set_false_path -to [get_registers *sys_gpio_bd|readdata[12]*]
set_false_path -to [get_registers *sys_gpio_bd|readdata[13]*]

set_false_path -from [get_registers *altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out*]

set_false_path -to [get_keepers {core_pll_locked_d1}]

set_clock_groups -asynchronous -group "ref_clk device_clk i_system_bd|jesd_core_pll|jesd_core_pll_link_clk"  -group {sys_clk_100mhz} -group {altera_reserved_tck}