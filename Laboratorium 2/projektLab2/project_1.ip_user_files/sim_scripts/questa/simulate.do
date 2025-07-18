onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib TB_TOP_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {TB_TOP.udo}

run 1000ns

quit -force
