# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/user/lab-3-5/vivado_workspace/kypd_demo_system/_ide/scripts/debugger_kypd_demo-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/user/lab-3-5/vivado_workspace/kypd_demo_system/_ide/scripts/debugger_kypd_demo-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo 210279A42C55A" && level==0 && jtag_device_ctx=="jsn-Zybo-210279A42C55A-13722093-0"}
fpga -file /home/user/lab-3-5/vivado_workspace/kypd_demo/_ide/bitstream/kypd_design_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/user/lab-3-5/vivado_workspace/kypd_design_wrapper/export/kypd_design_wrapper/hw/kypd_design_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/user/lab-3-5/vivado_workspace/kypd_demo/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/user/lab-3-5/vivado_workspace/kypd_demo/Debug/kypd_demo.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
