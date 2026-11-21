## Clock - Nexys A7 100 MHz
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


## Inputs - Switches

## SW0 -> coin5
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports coin5]

## SW1 -> coin10
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports coin10]

## SW2 -> select_A
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports select_A]

## SW3 -> select_B
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports select_B]


## Input - Push Button

## BTNC -> reset
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports reset]


## Outputs - LEDs

## LED0 -> dispense_A
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports dispense_A]

## LED1 -> dispense_B
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports dispense_B]

## LED2 -> change_5
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports change_5]

## LED3 -> change_10
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports change_10]