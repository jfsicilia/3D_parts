#!/bin/sh
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/ball_r10o0.5t2.stl -D 'b_roundness=0.5' -D 'b_thickness=2' -D 'b_radio=10' -D 'debug=false' ../ball.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/ball_r10.5o0.5t2.stl -D 'b_roundness=0.5' -D 'b_thickness=2' -D 'b_radio=10.5' -D 'debug=false' ../ball.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/ball_r11o0.5t2.stl -D 'b_roundness=0.5' -D 'b_thickness=2' -D 'b_radio=11' -D 'debug=false' ../ball.scad &
wait
