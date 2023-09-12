###############################################################################
## Copyright (C) 2021-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# RX parameters
set RX_NUM_OF_LINKS $ad_project_params(RX_NUM_LINKS)

# RX JESD parameter per link
set RX_JESD_M     $ad_project_params(RX_JESD_M)
set RX_JESD_L     $ad_project_params(RX_JESD_L)
set RX_JESD_S     $ad_project_params(RX_JESD_S)
set RX_JESD_NP    $ad_project_params(RX_JESD_NP)

set RX_TPL_DATA_PATH_WIDTH 4

set RX_NUM_OF_LANES      [expr $RX_JESD_L * $RX_NUM_OF_LINKS]
set RX_NUM_OF_CONVERTERS [expr $RX_JESD_M * $RX_NUM_OF_LINKS]
set RX_SAMPLES_PER_FRAME $RX_JESD_S
set RX_SAMPLE_WIDTH      $RX_JESD_NP
set RX_DMA_SAMPLE_WIDTH  16

set RX_SAMPLES_PER_CHANNEL [expr $RX_NUM_OF_LANES * 8*$RX_TPL_DATA_PATH_WIDTH / \
                                ($RX_NUM_OF_CONVERTERS * $RX_SAMPLE_WIDTH)]

# TX parameters
set TX_NUM_OF_LINKS $ad_project_params(TX_NUM_LINKS)

# TX JESD parameter per link
set TX_JESD_M     $ad_project_params(TX_JESD_M)
set TX_JESD_L     $ad_project_params(TX_JESD_L)
set TX_JESD_S     $ad_project_params(TX_JESD_S)
set TX_JESD_NP    $ad_project_params(TX_JESD_NP)

set TX_TPL_DATA_PATH_WIDTH 4

set TX_NUM_OF_LANES      [expr $TX_JESD_L * $TX_NUM_OF_LINKS]
set TX_NUM_OF_CONVERTERS [expr $TX_JESD_M * $TX_NUM_OF_LINKS]
set TX_SAMPLES_PER_FRAME $TX_JESD_S
set TX_SAMPLE_WIDTH      $TX_JESD_NP
set TX_DMA_SAMPLE_WIDTH  16

set TX_SAMPLES_PER_CHANNEL [expr $TX_NUM_OF_LANES * 8*$TX_TPL_DATA_PATH_WIDTH / \
                                ($TX_NUM_OF_CONVERTERS * $TX_SAMPLE_WIDTH)]

# Lane Rate = I/Q Sample Rate x M x N' x (10 \ 8) \ L
set TX_LANE_RATE [expr $ad_project_params(RX_LANE_RATE)*1000]
set RX_LANE_RATE [expr $ad_project_params(TX_LANE_RATE)*1000]

set adc_fifo_name mxfe_adc_fifo
set adc_data_width [expr 8*$RX_TPL_DATA_PATH_WIDTH*$RX_NUM_OF_LANES*$RX_DMA_SAMPLE_WIDTH/$RX_SAMPLE_WIDTH]
set adc_dma_data_width $adc_data_width
set adc_fifo_address_width [expr int(ceil(log(($adc_fifo_samples_per_converter*$RX_NUM_OF_CONVERTERS) / ($adc_data_width/$RX_DMA_SAMPLE_WIDTH))/log(2)))]

set dac_fifo_name mxfe_dac_fifo
set dac_data_width [expr 8*$TX_TPL_DATA_PATH_WIDTH*$TX_NUM_OF_LANES*$TX_DMA_SAMPLE_WIDTH/$TX_SAMPLE_WIDTH]
set dac_dma_data_width $dac_data_width
set dac_fifo_address_width [expr int(ceil(log(($dac_fifo_samples_per_converter*$TX_NUM_OF_CONVERTERS) / ($dac_data_width/$TX_DMA_SAMPLE_WIDTH))/log(2)))]

# JESD204B clock bridges

add_instance device_clk altera_clock_bridge
set_instance_parameter_value device_clk {EXPLICIT_CLOCK_RATE} {250000000}

add_instance xcvr_ref_clk altera_clock_bridge
set_instance_parameter_value xcvr_ref_clk {EXPLICIT_CLOCK_RATE} {250000000}

#
## IP instantions and configuration
#

# IOPLL (JESD core pll)

add_instance jesd_core_pll altera_iopll
set_instance_parameter_value jesd_core_pll {gui_debug_mode} {0}
set_instance_parameter_value jesd_core_pll {gui_include_iossm} {0}
set_instance_parameter_value jesd_core_pll {gui_cal_code_hex_file} {iossm.hex}
set_instance_parameter_value jesd_core_pll {gui_parameter_table_hex_file} {seq_params_sim.hex}
set_instance_parameter_value jesd_core_pll {gui_pll_tclk_mux_en} {0}
set_instance_parameter_value jesd_core_pll {gui_pll_tclk_sel} {pll_tclk_m_src}
set_instance_parameter_value jesd_core_pll {gui_pll_vco_freq_band_0} {pll_freq_clk0_disabled}
set_instance_parameter_value jesd_core_pll {gui_pll_vco_freq_band_1} {pll_freq_clk1_disabled}
set_instance_parameter_value jesd_core_pll {gui_pll_freqcal_en} {1}
set_instance_parameter_value jesd_core_pll {gui_pll_freqcal_req_flag} {1}
set_instance_parameter_value jesd_core_pll {gui_cal_converge} {0}
set_instance_parameter_value jesd_core_pll {gui_cal_error} {cal_clean}
set_instance_parameter_value jesd_core_pll {gui_pll_cal_done} {0}
set_instance_parameter_value jesd_core_pll {gui_pll_type} {S10_Simple}
set_instance_parameter_value jesd_core_pll {gui_pll_m_cnt_in_src} {c_m_cnt_in_src_ph_mux_clk}
set_instance_parameter_value jesd_core_pll {gui_usr_device_speed_grade} {1}
set_instance_parameter_value jesd_core_pll {gui_en_dps_ports} {0}
set_instance_parameter_value jesd_core_pll {gui_pll_mode} {Integer-N PLL}
set_instance_parameter_value jesd_core_pll {gui_reference_clock_frequency} {250.0}
set_instance_parameter_value jesd_core_pll {gui_reference_clock_frequency_ps} {4000.0}
set_instance_parameter_value jesd_core_pll {gui_fractional_cout} {32}
set_instance_parameter_value jesd_core_pll {gui_dsm_out_sel} {1st_order}
set_instance_parameter_value jesd_core_pll {gui_use_locked} {1}
set_instance_parameter_value jesd_core_pll {gui_en_adv_params} {0}
set_instance_parameter_value jesd_core_pll {gui_pll_bandwidth_preset} {Low}
set_instance_parameter_value jesd_core_pll {gui_lock_setting} {Low Lock Time}
set_instance_parameter_value jesd_core_pll {gui_pll_auto_reset} {0}
set_instance_parameter_value jesd_core_pll {gui_en_lvds_ports} {Disabled}
set_instance_parameter_value jesd_core_pll {gui_operation_mode} {source synchronous}
set_instance_parameter_value jesd_core_pll {gui_feedback_clock} {Global Clock}
set_instance_parameter_value jesd_core_pll {gui_clock_to_compensate} {0}
set_instance_parameter_value jesd_core_pll {gui_use_NDFB_modes} {0}
set_instance_parameter_value jesd_core_pll {gui_refclk_switch} {0}
set_instance_parameter_value jesd_core_pll {gui_refclk1_frequency} {100.0}
set_instance_parameter_value jesd_core_pll {gui_en_phout_ports} {0}
set_instance_parameter_value jesd_core_pll {gui_phout_division} {1}
set_instance_parameter_value jesd_core_pll {gui_en_extclkout_ports} {0}
set_instance_parameter_value jesd_core_pll {gui_number_of_clocks} {1}
set_instance_parameter_value jesd_core_pll {gui_multiply_factor} {6}
set_instance_parameter_value jesd_core_pll {gui_divide_factor_n} {1}
set_instance_parameter_value jesd_core_pll {gui_frac_multiply_factor} {1.0}
set_instance_parameter_value jesd_core_pll {gui_fix_vco_frequency} {0}
set_instance_parameter_value jesd_core_pll {gui_fixed_vco_frequency} {600.0}
set_instance_parameter_value jesd_core_pll {gui_vco_frequency} {600.0}
set_instance_parameter_value jesd_core_pll {gui_enable_output_counter_cascading} {0}
set_instance_parameter_value jesd_core_pll {gui_new_mif_file_path} {~/pll.mif}
set_instance_parameter_value jesd_core_pll {gui_existing_mif_file_path} {~/pll.mif}
set_instance_parameter_value jesd_core_pll {gui_mif_config_name} {unnamed}
set_instance_parameter_value jesd_core_pll {gui_active_clk} {0}
set_instance_parameter_value jesd_core_pll {gui_clk_bad} {0}
set_instance_parameter_value jesd_core_pll {gui_switchover_mode} {Automatic Switchover}
set_instance_parameter_value jesd_core_pll {gui_switchover_delay} {0}
set_instance_parameter_value jesd_core_pll {gui_enable_cascade_out} {0}
set_instance_parameter_value jesd_core_pll {gui_cascade_outclk_index} {0}
set_instance_parameter_value jesd_core_pll {gui_enable_cascade_in} {0}
set_instance_parameter_value jesd_core_pll {gui_pll_cascading_mode} {adjpllin}
set_instance_parameter_value jesd_core_pll {gui_enable_mif_dps} {0}
set_instance_parameter_value jesd_core_pll {gui_dps_cntr} {C0}
set_instance_parameter_value jesd_core_pll {gui_dps_num} {1}
set_instance_parameter_value jesd_core_pll {gui_dps_dir} {Positive}
set_instance_parameter_value jesd_core_pll {gui_extclkout_0_source} {C0}
set_instance_parameter_value jesd_core_pll {gui_clock_name_global} {0}
set_instance_parameter_value jesd_core_pll {gui_clock_name_string0} {link_clk}
set_instance_parameter_value jesd_core_pll {gui_divide_factor_c0} {6}
set_instance_parameter_value jesd_core_pll {gui_cascade_counter0} {0}
set_instance_parameter_value jesd_core_pll {gui_output_clock_frequency0} {250.0}
set_instance_parameter_value jesd_core_pll {gui_ps_units0} {ps}
set_instance_parameter_value jesd_core_pll {gui_phase_shift0} {0.0}
set_instance_parameter_value jesd_core_pll {gui_phase_shift_deg0} {0.0}
set_instance_parameter_value jesd_core_pll {gui_duty_cycle0} {50.0}
set_instance_parameter_value jesd_core_pll {hp_qsys_scripting_mode} {0}
set_instance_parameter_value jesd_core_pll {gui_en_reconf} {0}
set_instance_parameter_value jesd_core_pll {gui_mif_gen_options} {Generate New MIF File}

# PHY ATX PLL (external to JESD204 IP in the Stratix 10 case)
add_instance xcvr_atx_pll altera_xcvr_atx_pll_s10_htile
set_instance_parameter_value xcvr_atx_pll {rcfg_enable} {0}
set_instance_parameter_value xcvr_atx_pll {set_manual_reference_clock_frequency} {200.0}
set_instance_parameter_value xcvr_atx_pll {set_fref_clock_frequency} {156.25}
set_instance_parameter_value xcvr_atx_pll {rcfg_debug} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_jtag_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_separate_avmm_busy} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_enable_avmm_busy_port} {0}
set_instance_parameter_value xcvr_atx_pll {set_capability_reg_enable} {0}
set_instance_parameter_value xcvr_atx_pll {set_user_identifier} {0}
set_instance_parameter_value xcvr_atx_pll {set_csr_soft_logic_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_file_prefix} {altera_xcvr_atx_pll_s10}
set_instance_parameter_value xcvr_atx_pll {rcfg_sv_file_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_h_file_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_txt_file_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_mif_file_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_multi_enable} {0}
set_instance_parameter_value xcvr_atx_pll {set_rcfg_emb_strm_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_reduced_files_enable} {0}
set_instance_parameter_value xcvr_atx_pll {rcfg_profile_cnt} {2}
set_instance_parameter_value xcvr_atx_pll {rcfg_profile_select} {1}
set_instance_parameter_value xcvr_atx_pll {enable_manual_configuration} {1}
set_instance_parameter_value xcvr_atx_pll {generate_add_hdl_instance_example} {0}
set_instance_parameter_value xcvr_atx_pll {test_mode} {0}
set_instance_parameter_value xcvr_atx_pll {enable_pld_atx_cal_busy_port} {1}
set_instance_parameter_value xcvr_atx_pll {enable_debug_ports_parameters} {0}
set_instance_parameter_value xcvr_atx_pll {support_mode} {user_mode}
set_instance_parameter_value xcvr_atx_pll {message_level} {error}
set_instance_parameter_value xcvr_atx_pll {prot_mode} {Basic}
set_instance_parameter_value xcvr_atx_pll {bw_sel} {high}
set_instance_parameter_value xcvr_atx_pll {refclk_cnt} {1}
set_instance_parameter_value xcvr_atx_pll {refclk_index} {0}
set_instance_parameter_value xcvr_atx_pll {silicon_rev} {0}
set_instance_parameter_value xcvr_atx_pll {primary_pll_buffer} {GX clock output buffer}
set_instance_parameter_value xcvr_atx_pll {enable_8G_path} {1}
set_instance_parameter_value xcvr_atx_pll {enable_pcie_clk} {0}
set_instance_parameter_value xcvr_atx_pll {enable_cascade_out} {0} 
set_instance_parameter_value xcvr_atx_pll {enable_hip_cal_done_port} {0}
set_instance_parameter_value xcvr_atx_pll {set_hip_cal_en} {0}
set_instance_parameter_value xcvr_atx_pll {set_output_clock_frequency} {5000.0}
set_instance_parameter_value xcvr_atx_pll {set_auto_reference_clock_frequency} {250.0}
set_instance_parameter_value xcvr_atx_pll {set_m_counter} {24}
set_instance_parameter_value xcvr_atx_pll {set_ref_clk_div} {1}
set_instance_parameter_value xcvr_atx_pll {set_l_counter} {4}
set_instance_parameter_value xcvr_atx_pll {set_l_cascade_counter} {4}
set_instance_parameter_value xcvr_atx_pll {set_l_cascade_predivider} {1}
set_instance_parameter_value xcvr_atx_pll {set_k_counter} {1.0}
set_instance_parameter_value xcvr_atx_pll {enable_analog_resets} {0}
set_instance_parameter_value xcvr_atx_pll {enable_ext_lockdetect_ports} {0}
set_instance_parameter_value xcvr_atx_pll usr_analog_voltage {1_0V}
set_instance_parameter_value xcvr_atx_pll {enable_mcgb} {1}
set_instance_parameter_value xcvr_atx_pll {mcgb_div} {1}
set_instance_parameter_value xcvr_atx_pll {enable_mcgb_pcie_clksw} {0}
set_instance_parameter_value xcvr_atx_pll {mcgb_aux_clkin_cnt} {0}
set_instance_parameter_value xcvr_atx_pll {enable_fb_comp_bonding} {0}
set_instance_parameter_value xcvr_atx_pll {pma_width} {40}
set_instance_parameter_value xcvr_atx_pll {enable_pld_mcgb_cal_busy_port} {0}
set_instance_parameter_value xcvr_atx_pll {enable_hfreq_clk} {0}
set_instance_parameter_value xcvr_atx_pll {enable_bonding_clks} {1}

# Reset sequencer 

add_instance reset_seq altera_reset_sequencer
set_instance_parameter_value reset_seq {NUM_OUTPUTS} {8}
set_instance_parameter_value reset_seq {NUM_INPUTS} {1}
set_instance_parameter_value reset_seq {ENABLE_RESET_REQUEST_INPUT} {0}
set_instance_parameter_value reset_seq {MIN_ASRT_TIME} {20}
set_instance_parameter_value reset_seq {ENABLE_CSR} {1}
set_instance_parameter_value reset_seq {LIST_ASRT_SEQ} {0 1 2 3 4 5 6 7 8 9}
set_instance_parameter_value reset_seq {LIST_DSRT_SEQ} {0 1 2 3 4 5 6 7 8 9}
set_instance_parameter_value reset_seq {LIST_ASRT_DELAY} {0 0 0 0 0 0 0 0 0 0}
set_instance_parameter_value reset_seq {LIST_DSRT_DELAY} {2 2 2 20 0 2 20 0 0 0}
set_instance_parameter_value reset_seq {USE_DSRT_QUAL} {0 1 1 0 0 1 0 0 0 0}

# PHY reset controller

add_instance xcvr_reset_ctrl altera_xcvr_reset_control_s10
set_instance_parameter_value xcvr_reset_ctrl {TX_PLL_ENABLE} {0}
set_instance_parameter_value xcvr_reset_ctrl {T_TX_ANALOGRESET} {0}
set_instance_parameter_value xcvr_reset_ctrl {T_TX_DIGITALRESET} {20}
set_instance_parameter_value xcvr_reset_ctrl {T_RX_ANALOGRESET} {40}
set_instance_parameter_value xcvr_reset_ctrl {T_RX_DIGITALRESET} {5000}
set_instance_parameter_value xcvr_reset_ctrl {CHANNELS} {4}
set_instance_parameter_value xcvr_reset_ctrl {PLLS} {1}
set_instance_parameter_value xcvr_reset_ctrl {SYS_CLK_IN_MHZ} {100}
set_instance_parameter_value xcvr_reset_ctrl {REDUCED_SIM_TIME} {1}
set_instance_parameter_value xcvr_reset_ctrl {gui_split_interfaces} {0}
set_instance_parameter_value xcvr_reset_ctrl {TX_ENABLE} {1}
set_instance_parameter_value xcvr_reset_ctrl {T_PLL_POWERDOWN} {1000}
set_instance_parameter_value xcvr_reset_ctrl {TX_PER_CHANNEL} {0}
set_instance_parameter_value xcvr_reset_ctrl {T_PLL_LOCK_HYST} {0}
set_instance_parameter_value xcvr_reset_ctrl {gui_pll_cal_busy} {1}
set_instance_parameter_value xcvr_reset_ctrl {RX_ENABLE} {1}
set_instance_parameter_value xcvr_reset_ctrl {RX_PER_CHANNEL} {0}
set_instance_parameter_value xcvr_reset_ctrl {TILE_TYPE} {h_tile}

# RX+TX JESD204B PHY+Link layer
add_instance jesd_TX_RX altera_jesd204
set_instance_parameter_value jesd_TX_RX {wrapper_opt} {base_phy}
set_instance_parameter_value jesd_TX_RX {sdc_constraint} {1.0}
set_instance_parameter_value jesd_TX_RX {DATA_PATH} {RX_TX}
set_instance_parameter_value jesd_TX_RX {SUBCLASSV} {1}
set_instance_parameter_value jesd_TX_RX {lane_rate} $RX_LANE_RATE
set_instance_parameter_value jesd_TX_RX {PCS_CONFIG} {JESD_PCS_CFG2}
set_instance_parameter_value jesd_TX_RX {pll_type} {CMU}
set_instance_parameter_value jesd_TX_RX {pll_reconfig_enable} {false}
set_instance_parameter_value jesd_TX_RX {rcp_load_enable} {0}
set_instance_parameter_value jesd_TX_RX {cal_recipe_sel} {NRZ_28Gbps_VSR}
set_instance_parameter_value jesd_TX_RX {adpt_recipe_cnt} {1}
set_instance_parameter_value jesd_TX_RX {adpt_recipe_select} {0}
set_instance_parameter_value jesd_TX_RX {bonded_mode} {bonded}
set_instance_parameter_value jesd_TX_RX {REFCLK_FREQ} {250.0}
set_instance_parameter_value jesd_TX_RX {bitrev_en} {false}
set_instance_parameter_value jesd_TX_RX {rcfg_jtag_enable} {false}
set_instance_parameter_value jesd_TX_RX {rcfg_shared} {1}
set_instance_parameter_value jesd_TX_RX {set_capability_reg_enable} {false}
set_instance_parameter_value jesd_TX_RX {set_user_identifier} {0}
set_instance_parameter_value jesd_TX_RX {set_csr_soft_logic_enable} {false}
set_instance_parameter_value jesd_TX_RX {set_prbs_soft_logic_enable} {false}
set_instance_parameter_value jesd_TX_RX {L} $RX_NUM_OF_LANES
set_instance_parameter_value jesd_TX_RX {M} $RX_NUM_OF_CONVERTERS
set_instance_parameter_value jesd_TX_RX {GUI_EN_CFG_F} {0}
set_instance_parameter_value jesd_TX_RX {GUI_CFG_F} {2}
set_instance_parameter_value jesd_TX_RX {N} $RX_SAMPLE_WIDTH
set_instance_parameter_value jesd_TX_RX {N_PRIME} $RX_SAMPLE_WIDTH
set_instance_parameter_value jesd_TX_RX {S} $RX_SAMPLES_PER_FRAME
set_instance_parameter_value jesd_TX_RX {K} {32}
set_instance_parameter_value jesd_TX_RX {SCR} {1}
set_instance_parameter_value jesd_TX_RX {CS} {0}
set_instance_parameter_value jesd_TX_RX {CF} {0}
set_instance_parameter_value jesd_TX_RX {HD} {0}
set_instance_parameter_value jesd_TX_RX {ECC_EN} {true}
set_instance_parameter_value jesd_TX_RX {F} {2}
set_instance_parameter_value jesd_TX_RX {DLB_TEST} {0}
set_instance_parameter_value jesd_TX_RX {PHADJ} {0}
set_instance_parameter_value jesd_TX_RX {ADJCNT} {0}
set_instance_parameter_value jesd_TX_RX {ADJDIR} {0}
set_instance_parameter_value jesd_TX_RX {OPTIMIZE} {0}
set_instance_parameter_value jesd_TX_RX {DID} {0}
set_instance_parameter_value jesd_TX_RX {BID} {0}
set_instance_parameter_value jesd_TX_RX {LID0} {0}
set_instance_parameter_value jesd_TX_RX {LID1} {1}
set_instance_parameter_value jesd_TX_RX {LID2} {2}
set_instance_parameter_value jesd_TX_RX {LID3} {3}
set_instance_parameter_value jesd_TX_RX {LID4} {4}
set_instance_parameter_value jesd_TX_RX {LID5} {5}
set_instance_parameter_value jesd_TX_RX {LID6} {6}
set_instance_parameter_value jesd_TX_RX {LID7} {7}
set_instance_parameter_value jesd_TX_RX {JESDV} {1}
set_instance_parameter_value jesd_TX_RX {RES1} {0}
set_instance_parameter_value jesd_TX_RX {RES2} {0}
set_instance_parameter_value jesd_TX_RX {TEST_COMPONENTS_EN} {0}
set_instance_parameter_value jesd_TX_RX {TERMINATE_RECONFIG_EN} {0}
set_instance_parameter_value jesd_TX_RX {ED_FILESET_SYNTH} {0}
set_instance_parameter_value jesd_TX_RX {ED_FILESET_SIM} {0}
set_instance_parameter_value jesd_TX_RX {ED_HDL_FORMAT_SIM} {VERILOG}
set_instance_parameter_value jesd_TX_RX {ED_HDL_FORMAT_SYNTH} {VERILOG}
set_instance_parameter_value jesd_TX_RX {ED_DEV_KIT} {NONE}
set_instance_parameter_value jesd_TX_RX {gui_analog_voltage} {1_0V}


# JESD204B RX Transport 

add_instance mxfe_rx_tpl ad_ip_jesd204_tpl_adc
set_instance_parameter_value mxfe_rx_tpl {ID} {0}
set_instance_parameter_value mxfe_rx_tpl {NUM_CHANNELS} $RX_NUM_OF_CONVERTERS
set_instance_parameter_value mxfe_rx_tpl {NUM_LANES} $RX_NUM_OF_LANES
set_instance_parameter_value mxfe_rx_tpl {BITS_PER_SAMPLE} $RX_SAMPLE_WIDTH
set_instance_parameter_value mxfe_rx_tpl {CONVERTER_RESOLUTION} $RX_SAMPLE_WIDTH
set_instance_parameter_value mxfe_rx_tpl {TWOS_COMPLEMENT} {1}
set_instance_parameter_value mxfe_rx_tpl {OCTETS_PER_BEAT} $RX_TPL_DATA_PATH_WIDTH
set_instance_parameter_value mxfe_rx_tpl {DMA_BITS_PER_SAMPLE} $RX_DMA_SAMPLE_WIDTH

# JESD204B TX Transport

add_instance mxfe_tx_tpl ad_ip_jesd204_tpl_dac
set_instance_parameter_value mxfe_tx_tpl {ID} {0}
set_instance_parameter_value mxfe_tx_tpl {NUM_CHANNELS} $TX_NUM_OF_CONVERTERS
set_instance_parameter_value mxfe_tx_tpl {NUM_LANES} $TX_NUM_OF_LANES
set_instance_parameter_value mxfe_tx_tpl {BITS_PER_SAMPLE} $TX_SAMPLE_WIDTH
set_instance_parameter_value mxfe_tx_tpl {CONVERTER_RESOLUTION} $TX_SAMPLE_WIDTH
set_instance_parameter_value mxfe_tx_tpl {OCTETS_PER_BEAT} $TX_TPL_DATA_PATH_WIDTH
set_instance_parameter_value mxfe_tx_tpl {DMA_BITS_PER_SAMPLE} $TX_DMA_SAMPLE_WIDTH

# pack(s) & unpack(s)

add_instance mxfe_tx_upack util_upack2
set_instance_parameter_value mxfe_tx_upack {NUM_OF_CHANNELS} $TX_NUM_OF_CONVERTERS
set_instance_parameter_value mxfe_tx_upack {SAMPLES_PER_CHANNEL} $TX_SAMPLES_PER_CHANNEL
set_instance_parameter_value mxfe_tx_upack {SAMPLE_DATA_WIDTH} $TX_DMA_SAMPLE_WIDTH
set_instance_parameter_value mxfe_tx_upack {INTERFACE_TYPE} {1}

add_instance mxfe_rx_cpack util_cpack2
set_instance_parameter_value mxfe_rx_cpack {NUM_OF_CHANNELS} $RX_NUM_OF_CONVERTERS
set_instance_parameter_value mxfe_rx_cpack {SAMPLES_PER_CHANNEL} $RX_SAMPLES_PER_CHANNEL
set_instance_parameter_value mxfe_rx_cpack {SAMPLE_DATA_WIDTH} $RX_DMA_SAMPLE_WIDTH

# RX and TX data offload buffers

ad_adcfifo_create $adc_fifo_name $adc_data_width $adc_dma_data_width $adc_fifo_address_width
ad_dacfifo_create $dac_fifo_name $dac_data_width $dac_dma_data_width $dac_fifo_address_width

# RX and TX DMA instance and connections

add_instance mxfe_tx_dma axi_dmac
set_instance_parameter_value mxfe_tx_dma {ID} {0}
set_instance_parameter_value mxfe_tx_dma {DMA_DATA_WIDTH_SRC} {128}
set_instance_parameter_value mxfe_tx_dma {DMA_DATA_WIDTH_DEST} $dac_dma_data_width
set_instance_parameter_value mxfe_tx_dma {DMA_LENGTH_WIDTH} {24}
set_instance_parameter_value mxfe_tx_dma {DMA_2D_TRANSFER} {0}
set_instance_parameter_value mxfe_tx_dma {AXI_SLICE_DEST} {0}
set_instance_parameter_value mxfe_tx_dma {AXI_SLICE_SRC} {0}
set_instance_parameter_value mxfe_tx_dma {SYNC_TRANSFER_START} {0}
set_instance_parameter_value mxfe_tx_dma {CYCLIC} {1}
set_instance_parameter_value mxfe_tx_dma {DMA_TYPE_DEST} {1}
set_instance_parameter_value mxfe_tx_dma {DMA_TYPE_SRC} {0}
set_instance_parameter_value mxfe_tx_dma {FIFO_SIZE} {16}
set_instance_parameter_value mxfe_tx_dma {HAS_AXIS_TLAST} {1}
set_instance_parameter_value mxfe_tx_dma {DMA_AXI_PROTOCOL_SRC} {0}
set_instance_parameter_value mxfe_tx_dma {MAX_BYTES_PER_BURST} {4096}

add_instance mxfe_rx_dma axi_dmac
set_instance_parameter_value mxfe_rx_dma {ID} {0}
set_instance_parameter_value mxfe_rx_dma {DMA_DATA_WIDTH_SRC} $adc_dma_data_width
set_instance_parameter_value mxfe_rx_dma {DMA_DATA_WIDTH_DEST} {128}
set_instance_parameter_value mxfe_rx_dma {DMA_LENGTH_WIDTH} {24}
set_instance_parameter_value mxfe_rx_dma {DMA_2D_TRANSFER} {0}
set_instance_parameter_value mxfe_rx_dma {AXI_SLICE_DEST} {0}
set_instance_parameter_value mxfe_rx_dma {AXI_SLICE_SRC} {0}
set_instance_parameter_value mxfe_rx_dma {SYNC_TRANSFER_START} {0}
set_instance_parameter_value mxfe_rx_dma {CYCLIC} {0}
set_instance_parameter_value mxfe_rx_dma {DMA_TYPE_DEST} {0}
set_instance_parameter_value mxfe_rx_dma {DMA_TYPE_SRC} {1}
set_instance_parameter_value mxfe_rx_dma {FIFO_SIZE} {16}
set_instance_parameter_value mxfe_rx_dma {DMA_AXI_PROTOCOL_DEST} {0}
set_instance_parameter_value mxfe_rx_dma {MAX_BYTES_PER_BURST} {4096}

# mxfe gpio

add_instance avl_mxfe_gpio altera_avalon_pio
set_instance_parameter_value avl_mxfe_gpio {direction} {Bidir}
set_instance_parameter_value avl_mxfe_gpio {generateIRQ} {1}
set_instance_parameter_value avl_mxfe_gpio {width} {19}
add_connection sys_clk.clk avl_mxfe_gpio.clk
add_connection sys_clk.clk_reset avl_mxfe_gpio.reset
add_interface mxfe_gpio conduit end
set_interface_property mxfe_gpio EXPORT_OF avl_mxfe_gpio.external_connection

#
## clocks and resets
#

# system clock and reset

add_connection sys_clk.clk jesd_TX_RX.jesd204_rx_avs_clk
add_connection sys_clk.clk mxfe_rx_tpl.s_axi_clock
add_connection sys_clk.clk mxfe_rx_dma.s_axi_clock
add_connection sys_clk.clk jesd_TX_RX.jesd204_tx_avs_clk
add_connection sys_clk.clk mxfe_tx_tpl.s_axi_clock
add_connection sys_clk.clk mxfe_tx_dma.s_axi_clock
add_connection sys_clk.clk reset_seq.clk
add_connection sys_clk.clk xcvr_reset_ctrl.clock

add_connection sys_clk.clk_reset reset_seq.reset_in0
add_connection sys_clk.clk_reset jesd_TX_RX.jesd204_rx_avs_rst_n
add_connection sys_clk.clk_reset mxfe_rx_tpl.s_axi_reset
add_connection sys_clk.clk_reset mxfe_rx_dma.s_axi_reset
add_connection sys_clk.clk_reset jesd_TX_RX.jesd204_tx_avs_rst_n
add_connection sys_clk.clk_reset mxfe_tx_tpl.s_axi_reset
add_connection sys_clk.clk_reset mxfe_tx_dma.s_axi_reset
add_connection sys_clk.clk_reset reset_seq.csr_reset

# PHY clock & reset

add_connection xcvr_ref_clk.out_clk jesd_TX_RX.rx_pll_ref_clk

add_connection xcvr_ref_clk.out_clk xcvr_atx_pll.pll_refclk0 
add_connection xcvr_atx_pll.pll_cal_busy xcvr_reset_ctrl.pll_cal_busy
add_connection xcvr_atx_pll.tx_bonding_clocks jesd_TX_RX.tx_bonding_clocks_ch0
add_connection xcvr_atx_pll.tx_bonding_clocks jesd_TX_RX.tx_bonding_clocks_ch1
add_connection xcvr_atx_pll.tx_bonding_clocks jesd_TX_RX.tx_bonding_clocks_ch2
add_connection xcvr_atx_pll.tx_bonding_clocks jesd_TX_RX.tx_bonding_clocks_ch3


add_connection xcvr_reset_ctrl.tx_analogreset jesd_TX_RX.tx_analogreset
add_connection xcvr_reset_ctrl.rx_analogreset jesd_TX_RX.rx_analogreset
add_connection xcvr_reset_ctrl.tx_digitalreset jesd_TX_RX.tx_digitalreset
add_connection xcvr_reset_ctrl.rx_digitalreset jesd_TX_RX.rx_digitalreset
add_connection xcvr_reset_ctrl.tx_analogreset_stat jesd_TX_RX.tx_analogreset_stat
add_connection xcvr_reset_ctrl.rx_analogreset_stat jesd_TX_RX.rx_analogreset_stat
add_connection xcvr_reset_ctrl.tx_digitalreset_stat jesd_TX_RX.tx_digitalreset_stat
add_connection xcvr_reset_ctrl.rx_digitalreset_stat jesd_TX_RX.rx_digitalreset_stat
add_connection xcvr_reset_ctrl.rx_is_lockedtodata jesd_TX_RX.rx_islockedtodata
add_connection xcvr_reset_ctrl.tx_cal_busy jesd_TX_RX.tx_cal_busy
add_connection xcvr_reset_ctrl.rx_cal_busy jesd_TX_RX.rx_cal_busy

add_connection reset_seq.reset_out0 jesd_core_pll.reset
add_connection reset_seq.reset_out1 xcvr_reset_ctrl.reset
add_connection reset_seq.reset_out2 jesd_TX_RX.jesd204_tx_avs_rst_n
# add_connection reset_seq.reset_out3 -- jesd tx link reset (see device reset)
# add_connection reset_seq.reset_out4 -- jesd tx frame reset (see device reset)
add_connection reset_seq.reset_out5 jesd_TX_RX.jesd204_rx_avs_rst_n
# add_connection reset_seq.reset_out6 -- jesd rx link reset (see device reset)
# add_connection reset_seq.reset_out7 -- jesd rx frame reset (see device reset)


# device clock and reset

add_connection device_clk.out_clk jesd_core_pll.refclk
add_connection jesd_core_pll.outclk0 jesd_TX_RX.rxlink_clk
add_connection jesd_core_pll.outclk0 mxfe_rx_tpl.link_clk
add_connection jesd_core_pll.outclk0 mxfe_rx_cpack.clk
add_connection jesd_core_pll.outclk0 $adc_fifo_name.if_adc_clk

add_connection jesd_core_pll.outclk0 jesd_TX_RX.txlink_clk
add_connection jesd_core_pll.outclk0 mxfe_tx_tpl.link_clk
add_connection jesd_core_pll.outclk0 mxfe_tx_upack.clk
add_connection jesd_core_pll.outclk0 $dac_fifo_name.if_dac_clk

# rx resets from reset sequencer (out6 is link reset, out7 is frame reset)
add_connection reset_seq.reset_out6 mxfe_rx_cpack.reset
add_connection reset_seq.reset_out6 jesd_TX_RX.rxlink_rst_n
add_connection reset_seq.reset_out7 $adc_fifo_name.if_adc_rst

# tx resets from reset sequencer (out3 is link reset, out4 is frame reset)
add_connection reset_seq.reset_out3 mxfe_tx_upack.reset
add_connection reset_seq.reset_out6 jesd_TX_RX.txlink_rst_n
add_connection reset_seq.reset_out4 $dac_fifo_name.if_dac_rst

# dma clock and reset

add_connection sys_dma_clk.clk $adc_fifo_name.if_dma_clk
add_connection sys_dma_clk.clk mxfe_rx_dma.if_s_axis_aclk
add_connection sys_dma_clk.clk mxfe_rx_dma.m_dest_axi_clock

add_connection sys_dma_clk.clk_reset mxfe_rx_dma.m_dest_axi_reset

add_connection sys_dma_clk.clk $dac_fifo_name.if_dma_clk
add_connection sys_dma_clk.clk mxfe_tx_dma.if_m_axis_aclk
add_connection sys_dma_clk.clk mxfe_tx_dma.m_src_axi_clock

add_connection sys_dma_clk.clk_reset mxfe_tx_dma.m_src_axi_reset
add_connection sys_dma_clk.clk_reset $dac_fifo_name.if_dma_rst

# Misc connections on JESD IP

add_connection jesd_TX_RX.alldev_lane_aligned jesd_TX_RX.dev_lane_aligned
add_connection jesd_TX_RX.tx_dev_sync_n jesd_TX_RX.mdev_sync_n

#
## Exported signals
#

# JESD serial interface
add_interface rx_sysref                     conduit end
add_interface rx_sync                       conduit end
add_interface rx_serial_data                conduit end
add_interface tx_serial_data                conduit end
add_interface tx_sysref                     conduit end
add_interface tx_sync                       conduit end
add_interface device_clk                    clock   sink
add_interface xcvr_ref_clk                  clock   sink
# JESD reset logic
add_interface xcvr_reset_ctrl_pll_select    conduit end
add_interface xcvr_reset_ctrl_pll_locked    conduit end
add_interface xcvr_reset_ctrl_tx_ready      conduit end
add_interface xcvr_reset_ctrl_rx_ready      conduit end
add_interface reset_seq_dsrt1_qual          conduit end
add_interface reset_seq_dsrt2_qual          conduit end
add_interface reset_seq_dsrt5_qual          conduit end
add_interface jesd_pll_locked               conduit end
add_interface atx_pll_locked                conduit end
add_interface core_pll_locked               conduit end
# JESD CSR
add_interface tx_csr_testmode               conduit end
add_interface tx_csr_hd                     conduit end
add_interface tx_csr_cs                     conduit end
add_interface tx_csr_l                      conduit end
add_interface tx_csr_k                      conduit end
add_interface tx_csr_n                      conduit end
add_interface tx_csr_np                     conduit end
add_interface tx_csr_s                      conduit end
add_interface tx_csr_cf                     conduit end
add_interface tx_csr_f                      conduit end
add_interface tx_csr_m                      conduit end
add_interface tx_csr_lane_powerdown         conduit end
add_interface rx_csr_testmode               conduit end
add_interface rx_csr_f                      conduit end
add_interface rx_csr_k                      conduit end
add_interface rx_csr_l                      conduit end
add_interface rx_csr_m                      conduit end
add_interface rx_csr_n                      conduit end
add_interface rx_csr_s                      conduit end
add_interface rx_csr_cf                     conduit end
add_interface rx_csr_cs                     conduit end
add_interface rx_csr_hd                     conduit end
add_interface rx_csr_np                     conduit end
add_interface rx_csr_lane_powerdown         conduit end

set_interface_property rx_sysref                    EXPORT_OF jesd_TX_RX.rx_sysref
set_interface_property rx_sync                      EXPORT_OF jesd_TX_RX.rx_dev_sync_n
set_interface_property rx_serial_data               EXPORT_OF jesd_TX_RX.rx_serial_data
set_interface_property tx_sysref                    EXPORT_OF jesd_TX_RX.tx_sysref
set_interface_property tx_sync                      EXPORT_OF jesd_TX_RX.sync_n
set_interface_property tx_serial_data               EXPORT_OF jesd_TX_RX.tx_serial_data
set_interface_property device_clk                   EXPORT_OF device_clk.in_clk
set_interface_property xcvr_ref_clk                 EXPORT_OF xcvr_ref_clk.in_clk
set_interface_property xcvr_reset_ctrl_pll_select   EXPORT_OF xcvr_reset_ctrl.pll_select
set_interface_property xcvr_reset_ctrl_pll_locked   EXPORT_OF xcvr_reset_ctrl.pll_locked
set_interface_property xcvr_reset_ctrl_tx_ready     EXPORT_OF xcvr_reset_ctrl.tx_ready
set_interface_property xcvr_reset_ctrl_rx_ready     EXPORT_OF xcvr_reset_ctrl.rx_ready
set_interface_property reset_seq_dsrt1_qual         EXPORT_OF reset_seq.reset1_dsrt_qual
set_interface_property reset_seq_dsrt2_qual         EXPORT_OF reset_seq.reset2_dsrt_qual
set_interface_property reset_seq_dsrt5_qual         EXPORT_OF reset_seq.reset5_dsrt_qual
set_interface_property jesd_pll_locked              EXPORT_OF jesd_TX_RX.pll_locked  
set_interface_property atx_pll_locked               EXPORT_OF xcvr_atx_pll.pll_locked
set_interface_property core_pll_locked              EXPORT_OF jesd_core_pll.locked
set_interface_property tx_csr_testmode              EXPORT_OF jesd_TX_RX.csr_tx_testmode
set_interface_property tx_csr_hd                    EXPORT_OF jesd_TX_RX.tx_csr_hd
set_interface_property tx_csr_cs                    EXPORT_OF jesd_TX_RX.tx_csr_cs
set_interface_property tx_csr_l                     EXPORT_OF jesd_TX_RX.tx_csr_l
set_interface_property tx_csr_k                     EXPORT_OF jesd_TX_RX.tx_csr_k
set_interface_property tx_csr_n                     EXPORT_OF jesd_TX_RX.tx_csr_n
set_interface_property tx_csr_np                    EXPORT_OF jesd_TX_RX.tx_csr_np
set_interface_property tx_csr_s                     EXPORT_OF jesd_TX_RX.tx_csr_s
set_interface_property tx_csr_cf                    EXPORT_OF jesd_TX_RX.tx_csr_cf
set_interface_property tx_csr_f                     EXPORT_OF jesd_TX_RX.tx_csr_f
set_interface_property tx_csr_m                     EXPORT_OF jesd_TX_RX.tx_csr_m
set_interface_property tx_csr_lane_powerdown        EXPORT_OF jesd_TX_RX.tx_csr_lane_powerdown
set_interface_property rx_csr_testmode              EXPORT_OF jesd_TX_RX.csr_rx_testmode
set_interface_property rx_csr_f                     EXPORT_OF jesd_TX_RX.rx_csr_f
set_interface_property rx_csr_k                     EXPORT_OF jesd_TX_RX.rx_csr_k
set_interface_property rx_csr_l                     EXPORT_OF jesd_TX_RX.rx_csr_l
set_interface_property rx_csr_m                     EXPORT_OF jesd_TX_RX.rx_csr_m
set_interface_property rx_csr_n                     EXPORT_OF jesd_TX_RX.rx_csr_n
set_interface_property rx_csr_s                     EXPORT_OF jesd_TX_RX.rx_csr_s
set_interface_property rx_csr_cf                    EXPORT_OF jesd_TX_RX.rx_csr_cf
set_interface_property rx_csr_cs                    EXPORT_OF jesd_TX_RX.rx_csr_cs
set_interface_property rx_csr_hd                    EXPORT_OF jesd_TX_RX.rx_csr_hd
set_interface_property rx_csr_np                    EXPORT_OF jesd_TX_RX.rx_csr_np
set_interface_property rx_csr_lane_powerdown        EXPORT_OF jesd_TX_RX.rx_csr_lane_powerdown

#
## Data interface / data path
#

# RX link to tpl
add_connection jesd_TX_RX.rx_sof mxfe_rx_tpl.if_link_sof
add_connection jesd_TX_RX.jesd204_rx_link mxfe_rx_tpl.link_data
# RX tpl to cpack
for {set i 0} {$i < $RX_NUM_OF_CONVERTERS} {incr i} {
  add_connection mxfe_rx_tpl.adc_ch_$i mxfe_rx_cpack.adc_ch_$i
}
add_connection mxfe_rx_tpl.if_adc_dovf $adc_fifo_name.if_adc_wovf
# RX cpack to offload
add_connection mxfe_rx_cpack.if_packed_fifo_wr_en $adc_fifo_name.if_adc_wr
add_connection mxfe_rx_cpack.if_packed_fifo_wr_data $adc_fifo_name.if_adc_wdata
# RX offload to dma
add_connection $adc_fifo_name.if_dma_xfer_req mxfe_rx_dma.if_s_axis_xfer_req
add_connection $adc_fifo_name.m_axis mxfe_rx_dma.s_axis
# RX dma to HPS
ad_dma_interconnect mxfe_rx_dma.m_dest_axi

# TX link to tpl
add_connection mxfe_tx_tpl.link_data jesd_TX_RX.jesd204_tx_link
# TX tpl to pack
for {set i 0} {$i < $TX_NUM_OF_CONVERTERS} {incr i} {
  add_connection mxfe_tx_upack.dac_ch_$i mxfe_tx_tpl.dac_ch_$i
}
# TX pack to offload
add_connection mxfe_tx_upack.if_packed_fifo_rd_en $dac_fifo_name.if_dac_valid
add_connection $dac_fifo_name.if_dac_data mxfe_tx_upack.if_packed_fifo_rd_data
add_connection $dac_fifo_name.if_dac_dunf mxfe_tx_tpl.if_dac_dunf
# TX offload to dma
add_connection mxfe_tx_dma.if_m_axis_xfer_req $dac_fifo_name.if_dma_xfer_req
add_connection mxfe_tx_dma.m_axis $dac_fifo_name.s_axis
# TX dma to HPS
ad_dma_interconnect mxfe_tx_dma.m_src_axi

# reconfiguration interface sharing

set MAX_NUM_OF_LANES $TX_NUM_OF_LANES
if {$RX_NUM_OF_LANES > $TX_NUM_OF_LANES} {
  set MAX_NUM_OF_LANES $RX_NUM_OF_LANES
}

#
## address map
#

## NOTE: if a bridge is used, the address will be bridge_base_addr + peripheral_base_addr
#

ad_cpu_interconnect 0x00020000 jesd_TX_RX.jesd204_rx_avs "avl_mm_bridge_0" 0x00040000

ad_cpu_interconnect 0x00020000 jesd_TX_RX.jesd204_tx_avs "avl_mm_bridge_1" 0x00080000


ad_cpu_interconnect 0x000D2000 mxfe_rx_tpl.s_axi
ad_cpu_interconnect 0x000D4000 mxfe_tx_tpl.s_axi
ad_cpu_interconnect 0x000D8000 mxfe_rx_dma.s_axi
ad_cpu_interconnect 0x000DC000 mxfe_tx_dma.s_axi
ad_cpu_interconnect 0x000E0000 avl_mxfe_gpio.s1
ad_cpu_interconnect 0x000E2000 reset_seq.av_csr

#
## interrupts
#

ad_cpu_interrupt 11  mxfe_rx_dma.interrupt_sender
ad_cpu_interrupt 12  mxfe_tx_dma.interrupt_sender
ad_cpu_interrupt 13  jesd_TX_RX.jesd204_rx_int
ad_cpu_interrupt 14  jesd_TX_RX.jesd204_tx_int
ad_cpu_interrupt 15  avl_mxfe_gpio.irq
#ad_cpu_interrupt FIXME reset_seq.av_csr_irq


