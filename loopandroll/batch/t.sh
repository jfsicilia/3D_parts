#!/bin/sh
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t3h2.stl -D 'f_roundness=1' -D 'f_holes=2' -D 'f_thickness=3' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t3h3.stl -D 'f_roundness=1' -D 'f_holes=3' -D 'f_thickness=3' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t3h4.stl -D 'f_roundness=1' -D 'f_holes=4' -D 'f_thickness=3' -D 'debug=false' ../frame.scad &
wait
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t3h5.stl -D 'f_roundness=1' -D 'f_holes=5' -D 'f_thickness=3' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t3h6.stl -D 'f_roundness=1' -D 'f_holes=6' -D 'f_thickness=3' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t3h7.stl -D 'f_roundness=1' -D 'f_holes=7' -D 'f_thickness=3' -D 'debug=false' ../frame.scad &
wait
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t4h2.stl -D 'f_roundness=1' -D 'f_holes=2' -D 'f_thickness=4' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t4h3.stl -D 'f_roundness=1' -D 'f_holes=3' -D 'f_thickness=4' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t4h4.stl -D 'f_roundness=1' -D 'f_holes=4' -D 'f_thickness=4' -D 'debug=false' ../frame.scad &
wait
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t4h5.stl -D 'f_roundness=1' -D 'f_holes=5' -D 'f_thickness=4' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t4h6.stl -D 'f_roundness=1' -D 'f_holes=6' -D 'f_thickness=4' -D 'debug=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_r1t4h7.stl -D 'f_roundness=1' -D 'f_holes=7' -D 'f_thickness=4' -D 'debug=false' ../frame.scad &
wait
