

set_instance_assignment -name IO_STANDARD IOSTANDARD -to System_top_name
set_instance_assignment -name Termination -to System_top_name

set_location_assignment PIN_BG43 -to rx_serial_data[2]      ; ## A6   FMCA_DP02_M2C_P     GXBL1C_RX_CH2p,GXBL1C_REFCLK2p
set_location_assignment PIN_BG42 -to "rx_serial_data[2](n)" ; ## A7   FMCA_DP02_M2C_N     GXBL1C_RX_CH2n,GXBL1C_REFCLK2n
set_location_assignment PIN_BH41 -to rx_serial_data[0]      ; ## C6   FMCA_DP00_M2C_P     GXBL1C_RX_CH0p,GXBL1C_REFCLK0p
set_location_assignment PIN_BH40 -to "rx_serial_data[0](n)" ; ## C7   FMCA_DP00_M2C_N     GXBL1C_RX_CH0n,GXBL1C_REFCLK0n
set_location_assignment PIN_BB45 -to rx_serial_data[7]      ; ## B12  FMCA_DP07_M2C_P     GXBL1D_RX_CH1p,GXBL1D_REFCLK1p
set_location_assignment PIN_BB44 -to "rx_serial_data[7](n)" ; ## B13  FMCA_DP07_M2C_N     GXBL1D_RX_CH1n,GXBL1D_REFCLK1n
set_location_assignment PIN_BA43 -to rx_serial_data[6]      ; ## B16  FMCA_DP06_M2C_P     GXBL1D_RX_CH0p,GXBL1D_REFCLK0p
set_location_assignment PIN_BA42 -to "rx_serial_data[6](n)" ; ## B17  FMCA_DP06_M2C_N     GXBL1D_RX_CH0n,GXBL1D_REFCLK0n
set_location_assignment PIN_BD45 -to rx_serial_data[5]      ; ## A18  FMCA_DP05_M2C_P     GXBL1C_RX_CH5p,GXBL1C_REFCLK5p
set_location_assignment PIN_BD44 -to "rx_serial_data[5](n)" ; ## A19  FMCA_DP05_M2C_N     GXBL1C_RX_CH5n,GXBL1C_REFCLK5n
set_location_assignment PIN_BC43 -to rx_serial_data[4]      ; ## A14  FMCA_DP04_M2C_P     GXBL1C_RX_CH4p,GXBL1C_REFCLK4p
set_location_assignment PIN_BC42 -to "rx_serial_data[4](n)" ; ## A15  FMCA_DP04_M2C_N     GXBL1C_RX_CH4n,GXBL1C_REFCLK4n
set_location_assignment PIN_BE43 -to rx_serial_data[3]      ; ## A10  FMCA_DP03_M2C_P     GXBL1C_RX_CH3p,GXBL1C_REFCLK3p
set_location_assignment PIN_BE42 -to "rx_serial_data[3](n)" ; ## A11  FMCA_DP03_M2C_N     GXBL1C_RX_CH3n,GXBL1C_REFCLK3n
set_location_assignment PIN_BJ43 -to rx_serial_data[1]      ; ## A2   FMCA_DP01_M2C_P     GXBL1C_RX_CH1p,GXBL1C_REFCLK1p
set_location_assignment PIN_BJ42 -to "rx_serial_data[1](n)" ; ## A3   FMCA_DP01_M2C_N     GXBL1C_RX_CH1n,GXBL1C_REFCLK1n
set_location_assignment PIN_BJ46 -to tx_serial_data[0]      ; ## C2   FMCA_DP00_C2M_P     GXBL1C_TX_CH0p
set_location_assignment PIN_BJ45 -to "tx_serial_data[0](n)" ; ## C3   FMCA_DP00_C2M_N     GXBL1C_TX_CH0n
set_location_assignment PIN_BG47 -to tx_serial_data[2]      ; ## A26  FMCA_DP02_C2M_P     GXBL1C_TX_CH2p
set_location_assignment PIN_BG46 -to "tx_serial_data[2](n)" ; ## A27  FMCA_DP02_C2M_N     GXBL1C_TX_CH2n
set_location_assignment PIN_BA47 -to tx_serial_data[7]      ; ## B32  FMCA_DP07_C2M_P     GXBL1D_TX_CH1p
set_location_assignment PIN_BA46 -to "tx_serial_data[7](n)" ; ## B33  FMCA_DP07_C2M_N     GXBL1D_TX_CH1n
set_location_assignment PIN_BD49 -to tx_serial_data[6]      ; ## B36  FMCA_DP06_C2M_P     GXBL1D_TX_CH0p
set_location_assignment PIN_BD48 -to "tx_serial_data[6](n)" ; ## B37  FMCA_DP06_C2M_N     GXBL1D_TX_CH0n
set_location_assignment PIN_BF45 -to tx_serial_data[1]      ; ## A22  FMCA_DP01_C2M_P     GXBL1C_TX_CH1p
set_location_assignment PIN_BF44 -to "tx_serial_data[1](n)" ; ## A23  FMCA_DP01_C2M_N     GXBL1C_TX_CH1n
set_location_assignment PIN_BC47 -to tx_serial_data[5]      ; ## A38  FMCA_DP05_C2M_P     GXBL1C_TX_CH5p
set_location_assignment PIN_BC46 -to "tx_serial_data[5](n)" ; ## A39  FMCA_DP05_C2M_N     GXBL1C_TX_CH5n
set_location_assignment PIN_BF49 -to tx_serial_data[4]      ; ## A34  FMCA_DP04_C2M_P     GXBL1C_TX_CH4p
set_location_assignment PIN_BF48 -to "tx_serial_data[4](n)" ; ## A35  FMCA_DP04_C2M_N     GXBL1C_TX_CH4n
set_location_assignment PIN_BE47 -to tx_serial_data[3]      ; ## A30  FMCA_DP03_C2M_P     GXBL1C_TX_CH3p
set_location_assignment PIN_BE46 -to "tx_serial_data[3](n)" ; ## A31  FMCA_DP03_C2M_N     GXBL1C_TX_CH3n

set_instance_assignment -name XCVR_VCCR_VCCT_VOLTAGE 1_0V -to rx_serial_data
set_instance_assignment -name XCVR_VCCR_VCCT_VOLTAGE 1_0V -to tx_serial_data

set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to rx_serial_data
set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to tx_serial_data

for {set i 0} {$i < $common_lanes} {incr i} {
  set_instance_assignment -name XCVR_RECONFIG_GROUP xcvr_${i} -to rx_serial_data[${i}]
  set_instance_assignment -name XCVR_RECONFIG_GROUP xcvr_${i} -to tx_serial_data[${i}]
}

set_location_assignment PIN_AN20 -to fpga_syncin_0          ; ## H7   FMCA_LA02_P         IO,LVDS3C_9p
set_location_assignment PIN_AP20 -to "fpga_syncin_0(n)"     ; ## H8   FMCA_LA02_N         IO,LVDS3C_9n
set_location_assignment PIN_BC31 -to fpga_syncin_1          ; ## G9   FMCA_LA03_P         IO,LVDS2A_9p
set_location_assignment PIN_BC32 -to "fpga_syncin_1(n)"     ; ## G10  FMCA_LA03_N         IO,LVDS2A_9n
set_location_assignment PIN_BE31 -to fpga_syncout_0         ; ## D8   FMCA_LA01_CC_P      IO,CLK_2A_0p,LVDS2A_13p
set_location_assignment PIN_BD31 -to "fpga_syncout_0(n)"    ; ## D9   FMCA_LA01_CC_N      IO,CLK_2A_0n,LVDS2A_13n
set_location_assignment PIN_BF31 -to fpga_syncout_1         ; ## C10  FMCA_LA06_P         IO,PLL_2A_CLKOUT0p,PLL_2A_CLKOUT0,PLL_2A_FB0,LVDS2A_15p
set_location_assignment PIN_BF30 -to "fpga_syncout_1(n)"    ; ## C11  FMCA_LA06_N         IO,PLL_2A_CLKOUT0n,LVDS2A_15n

set_instance_assignment -name IO_STANDARD LVDS15 -to fpga_syncin_0
set_instance_assignment -name IO_STANDARD "1.8 V" -to fpga_syncin_1
set_instance_assignment -name IO_STANDARD LVDS15 -to fpga_syncout_0
set_instance_assignment -name IO_STANDARD "1.8 V" -to fpga_syncout_1
set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL_ADV -to fpga_syncin_0

set_location_assignment PIN_AP41 -to fpga_refclk_in         ; ## D4   FMCA_GBTCLK0_M2C_P  REFCLK_GXBL1C_CHTp
set_location_assignment PIN_AP40 -to "fpga_refclk_in(n)"    ; ## D5   FMCA_GBTCLK0_M2C_N  REFCLK_GXBL1C_CHTn
set_location_assignment PIN_BF21 -to sysref2                ; ## H4   FMCA_CLK0_M2C_P     IO,CLK_3C_0p,LVDS3C_13p
set_location_assignment PIN_BE21 -to "sysref2(n)"           ; ## H5   FMCA_CLK0_M2C_N     IO,CLK_3C_0n,LVDS3C_13n
set_location_assignment PIN_AR19 -to clkin6                 ; ## G2   FMCA_CLK1_M2C_P     IO,CLK_3C_1p,LVDS3C_12p
set_location_assignment PIN_AT19 -to "clkin6(n)"            ; ## G3   FMCA_CLK1_M2C_N     IO,CLK_3C_1n,LVDS3C_12n
set_location_assignment PIN_AW30 -to clkin10                ; ## G6   FMCA_LA00_CC_P      IO,CLK_2A_1p,LVDS2A_12p
set_location_assignment PIN_AW31 -to "clkin10(n)"           ; ## G7   FMCA_LA00_CC_N      IO,CLK_2A_1n,LVDS2A_12n
set_location_assignment PIN_BF32 -to hmc_sync               ; ## H14  FMCA_LA07_N         IO,LVDS2A_23n

set_instance_assignment -name IO_STANDARD LVDS15 -to sysref2
set_instance_assignment -name IO_STANDARD LVDS15 -to clkin6
set_instance_assignment -name IO_STANDARD LVDS15 -to clkin10
set_instance_assignment -name IO_STANDARD "1.8 V" -to hmc_sync
set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL_ADV -to sysref2
set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL_ADV -to clkin6
set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL_ADV -to clkin10

set_location_assignment PIN_BE32 -to rstb                   ; ## H13  FMCA_LA07_P         IO,LVDS2A_23p
set_location_assignment PIN_BA31 -to txen[0]                ; ## D14  FMCA_LA09_P         IO,LVDS2A_7p
set_location_assignment PIN_BA30 -to txen[1]                ; ## D15  FMCA_LA09_N         IO,LVDS2A_7n
set_location_assignment PIN_BB33 -to rxen[0]                ; ## C14  FMCA_LA10_P         IO,LVDS2B_3p
set_location_assignment PIN_BB34 -to rxen[1]                ; ## C15  FMCA_LA10_N         IO,LVDS2B_3n
set_location_assignment PIN_AN17 -to gpio[0]                ; ## H19  FMCA_LA15_P         IO,RZQ_3B,LVDS3B_11p
set_location_assignment PIN_AN18 -to gpio[1]                ; ## H20  FMCA_LA15_N         IO,LVDS3B_11n
set_location_assignment PIN_BE18 -to gpio[2]                ; ## H22  FMCA_LA19_P         IO,LVDS3C_18p
set_location_assignment PIN_BD18 -to gpio[3]                ; ## H23  FMCA_LA19_N         IO,LVDS3C_18n
set_location_assignment PIN_AT21 -to gpio[4]                ; ## D17  FMCA_LA13_P         IO,LVDS3C_7p
set_location_assignment PIN_AR21 -to gpio[5]                ; ## D18  FMCA_LA13_N         IO,LVDS3C_7n
set_location_assignment PIN_AU32 -to gpio[6]                ; ## C18  FMCA_LA14_P         IO,LVDS2B_19p
set_location_assignment PIN_AT32 -to gpio[7]                ; ## C19  FMCA_LA14_N         IO,LVDS2B_19n
set_location_assignment PIN_BA20 -to gpio[8]                ; ## G18  FMCA_LA16_P         IO,LVDS3C_1p
set_location_assignment PIN_BA21 -to gpio[9]                ; ## G19  FMCA_LA16_N         IO,LVDS3C_1n
set_location_assignment PIN_BJ36 -to gpio[10]               ; ## G25  FMCA_LA22_N         IO,LVDS2B_11n
set_location_assignment PIN_BH32 -to irqb[0]                ; ## G12  FMCA_LA08_P         IO,LVDS2A_24p
set_location_assignment PIN_BG32 -to irqb[1]                ; ## G13  FMCA_LA08_N         IO,LVDS2A_24n
set_location_assignment PIN_AT16 -to hmc_gpio1              ; ## H17  FMCA_LA11_N         IO,LVDS3B_9n

set_instance_assignment -name IO_STANDARD "1.8 V" -to rstb
set_instance_assignment -name IO_STANDARD "1.8 V" -to txen[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to txen[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to rxen[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to rxen[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[2]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[3]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[4]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[5]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[6]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[7]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[8]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[9]
set_instance_assignment -name IO_STANDARD "1.8 V" -to gpio[10]
set_instance_assignment -name IO_STANDARD "1.8 V" -to irqb[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to irqb[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to hmc_gpio1

set_location_assignment PIN_BG30 -to spi0_csb               ; ## D11  FMCA_LA05_P         IO,LVDS2A_18p
set_location_assignment PIN_BC30 -to spi0_sclk              ; ## H10  FMCA_LA04_P         IO,LVDS2A_16p
set_location_assignment PIN_BD30 -to spi0_mosi              ; ## H11  FMCA_LA04_N         IO,LVDS2A_16n
set_location_assignment PIN_BH30 -to spi0_miso              ; ## D12  FMCA_LA05_N         IO,LVDS2A_18n
set_location_assignment PIN_AU29 -to spi1_csb               ; ## G15  FMCA_LA12_P         IO,LVDS2A_1p
set_location_assignment PIN_AT15 -to spi1_sclk              ; ## H16  FMCA_LA11_P         IO,LVDS3B_9p
set_location_assignment PIN_AU28 -to spi1_sdio              ; ## G16  FMCA_LA12_N         IO,LVDS2A_1n

set_instance_assignment -name IO_STANDARD "1.8 V" -to spi0_csb
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi0_sclk
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi0_mosi
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi0_miso
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi1_csb
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi1_sclk
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi1_sdio

set_location_assignment PIN_AT17 -to agc0[0]                ; ## D20  FMCA_LA17_CC_P      IO,CLK_3B_1p,LVDS3B_12p
set_location_assignment PIN_AU17 -to agc0[1]                ; ## D21  FMCA_LA17_CC_N      IO,CLK_3B_1n,LVDS3B_12n
set_location_assignment PIN_BG17 -to agc1[0]                ; ## C22  FMCA_LA18_CC_P      IO,LVDS3C_21p
set_location_assignment PIN_BH17 -to agc1[1]                ; ## C23  FMCA_LA18_CC_N      IO,LVDS3C_21n
set_location_assignment PIN_AN21 -to agc2[0]                ; ## G21  FMCA_LA20_P         IO,PLL_3C_CLKOUT1p,PLL_3C_CLKOUT1,PLL_3C_FB1,LVDS3C_10p
set_location_assignment PIN_AP21 -to agc2[1]                ; ## G22  FMCA_LA20_N         IO,PLL_3C_CLKOUT1n,LVDS3C_10n
set_location_assignment PIN_BG18 -to agc3[0]                ; ## H25  FMCA_LA21_P         IO,LVDS3C_19p
set_location_assignment PIN_BG19 -to agc3[1]                ; ## H26  FMCA_LA21_N         IO,LVDS3C_19n

set_instance_assignment -name IO_STANDARD "1.8 V" -to agc0[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to agc0[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to agc1[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to agc1[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to agc2[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to agc2[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to agc3[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to agc3[1]

