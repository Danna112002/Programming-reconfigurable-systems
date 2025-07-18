transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+TB_TOP  -L xil_defaultlib -L secureip -O5 xil_defaultlib.TB_TOP

do {TB_TOP.udo}

run 1000ns

endsim

quit -force
