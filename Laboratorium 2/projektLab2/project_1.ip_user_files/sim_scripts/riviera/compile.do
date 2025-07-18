transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vcom -work xil_defaultlib -93  -incr \
"../../../../licznik.vhd" \
"../../../../zegar.vhd" \
"../../../../zegar_tb.vhd" \


