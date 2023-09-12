###############################################################################
## Copyright (C) 2021-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

source ../../../scripts/adi_env.tcl
source ../../scripts/adi_project_intel.tcl

# get_env_param retrieves parameter value from the environment if exists,
# other case use the default value
#
#   Use over-writable parameters from the environment.
#
#    e.g.
#      make RX_LANE_RATE=10 TX_LANE_RATE=10 RX_JESD_L=4 RX_JESD_M=8 RX_JESD_S=1 RX_JESD_NP=16 TX_JESD_L=4 TX_JESD_M=8 TX_JESD_S=1 TX_JESD_NP=16
#      make RX_LANE_RATE=2.5 TX_LANE_RATE=2.5 RX_JESD_L=8 RX_JESD_M=4 RX_JESD_S=1 RX_JESD_NP=16 TX_JESD_L=8 TX_JESD_M=4 TX_JESD_S=1 TX_JESD_NP=16
#      make RX_LANE_RATE=10 TX_LANE_RATE=10 RX_JESD_L=2 RX_JESD_M=8 RX_JESD_S=1 RX_JESD_NP=12 TX_JESD_L=2 TX_JESD_M=8 TX_JESD_S=1 TX_JESD_NP=12
#
# Lane Rate = I/Q Sample Rate x M x N' x (10 \ 8) \ L

# Parameter description:
#
#   RX_LANE_RATE :  Lane rate of the Rx link ( MxFE to FPGA )
#   TX_LANE_RATE :  Lane rate of the Tx link ( FPGA to MxFE )
#   [RX/TX]_JESD_M : Number of converters per link
#   [RX/TX]_JESD_L : Number of lanes per link
#   [RX/TX]_JESD_S : Number of samples per frame
#   [RX/TX]_JESD_NP : Number of bits per sample
#   [RX/TX]_NUM_LINKS : Number of links
#   [RX/TX]_KS_PER_CHANNEL : Number of samples stored in internal buffers in kilosamples per converter (M)
#

adi_project ad9081_fmca_ebz_s10soc [list \
  RX_LANE_RATE       [get_env_param RX_LANE_RATE      10 ] \
  TX_LANE_RATE       [get_env_param TX_LANE_RATE      10 ] \
  RX_JESD_M          [get_env_param RX_JESD_M          8 ] \
  RX_JESD_L          [get_env_param RX_JESD_L          4 ] \
  RX_JESD_S          [get_env_param RX_JESD_S          1 ] \
  RX_JESD_NP         [get_env_param RX_JESD_NP        16 ] \
  RX_NUM_LINKS       [get_env_param RX_NUM_LINKS       1 ] \
  TX_JESD_M          [get_env_param TX_JESD_M          8 ] \
  TX_JESD_L          [get_env_param TX_JESD_L          4 ] \
  TX_JESD_S          [get_env_param TX_JESD_S          1 ] \
  TX_JESD_NP         [get_env_param TX_JESD_NP        16 ] \
  TX_NUM_LINKS       [get_env_param TX_NUM_LINKS       1 ] \
  RX_KS_PER_CHANNEL  [get_env_param RX_KS_PER_CHANNEL 32 ] \
  TX_KS_PER_CHANNEL  [get_env_param TX_KS_PER_CHANNEL 32 ] \
]

source $ad_hdl_dir/projects/common/s10soc/s10soc_system_assign.tcl


# files

set_global_assignment -name VERILOG_FILE $ad_hdl_dir/library/common/ad_3w_spi.v


# Note: This projects requires a hardware rework to function correctly.
# The rework connects FMC header pins directly to the FPGA so that they can be
# accessed by the fabric.
#
# Changes required:
#  R232: DNI -> R0    PIN_BE31
#  R233: DNI -> R0    PIN_BD31
#  R228: R0 -> DNI
#  R229: R0 -> DNI
#
# This project requires the use of the FMCA connector (J11 on schematic)

set common_lanes 0
set common_lanes [get_env_param RX_JESD_L 4]
if {$common_lanes > [get_env_param TX_JESD_L 4]} {
  set common_lanes [get_env_param TX_JESD_L 4]
}

source fmc_constr.tcl

# transceiver calibration clock
set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_125MHZ

# set optimization to get a better timing closure
set_global_assignment -name OPTIMIZATION_MODE "HIGH PERFORMANCE EFFORT"
set_global_assignment -name PLACEMENT_EFFORT_MULTIPLIER 1.2

# execute_flow -compile
