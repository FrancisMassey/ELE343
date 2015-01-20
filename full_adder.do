#fichier de commande pour addtb.vhd

vcom full_adder.vhd
vsim full_adder

add wave *

# Forcer les signaux

force a '1'
force b '0'
force c_i '0'
run 15ns


force a '0'
force b '1'
force c_i '1'
run 20ns


force a '1'
force b '0'
force c_i '1'
run 20ns

wave zoom full
