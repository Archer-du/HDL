## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; 
set_property -dict { PACKAGE_PIN B18  IOSTANDARD LVCMOS33} [get_ports { en }];
## FPGAOL SWITCH
set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33 } [get_ports { d[0] }];
set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { d[1] }];
set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { d[2] }];
set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33 } [get_ports { d[3] }];
set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { d[4] }];
set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33 } [get_ports { d[5] }];
set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { d[6] }];
set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { rst }];
## FPGAOL LED
set_property -dict { PACKAGE_PIN C17  IOSTANDARD LVCMOS33} [get_ports { f[0] }];
set_property -dict { PACKAGE_PIN D18  IOSTANDARD LVCMOS33} [get_ports { f[1] }];
set_property -dict { PACKAGE_PIN E18  IOSTANDARD LVCMOS33} [get_ports { f[2] }];
set_property -dict { PACKAGE_PIN G17  IOSTANDARD LVCMOS33} [get_ports { f[3] }];
set_property -dict { PACKAGE_PIN D17  IOSTANDARD LVCMOS33} [get_ports { f[4] }];
set_property -dict { PACKAGE_PIN E17  IOSTANDARD LVCMOS33} [get_ports { f[5] }];
set_property -dict { PACKAGE_PIN F18  IOSTANDARD LVCMOS33} [get_ports { f[6] }];