#fichier de commande pour addtb.vhd
vcom txt_util.vhd
vcom addtb.vhd
vcom full_adder_generic.vhd
vsim addtb

add wave -hex *

run 300 ns

wave zoom full