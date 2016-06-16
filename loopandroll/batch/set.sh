#!/bin/sh

# Frames.
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h2none.stl -D 'ROUNDNESS=1' -D 'HOLES=2' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="none"' -D 'DEBUG=false' ../frame.scad &
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h3none.stl -D 'ROUNDNESS=1' -D 'HOLES=3' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="none"' -D 'DEBUG=false' ../frame.scad &
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h4none.stl -D 'ROUNDNESS=1' -D 'HOLES=4' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="none"' -D 'DEBUG=false' ../frame.scad &
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h5none.stl -D 'ROUNDNESS=1' -D 'HOLES=5' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="none"' -D 'DEBUG=false' ../frame.scad &
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h6none.stl -D 'ROUNDNESS=1' -D 'HOLES=6' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="none"' -D 'DEBUG=false' ../frame.scad &
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h7none.stl -D 'ROUNDNESS=1' -D 'HOLES=7' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="none"' -D 'DEBUG=false' ../frame.scad &

~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h2double.stl -D 'ROUNDNESS=1' -D 'HOLES=2' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="double"' -D 'DEBUG=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h3double.stl -D 'ROUNDNESS=1' -D 'HOLES=3' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="double"' -D 'DEBUG=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h4double.stl -D 'ROUNDNESS=1' -D 'HOLES=4' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="double"' -D 'DEBUG=false' ../frame.scad &
wait
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h5double.stl -D 'ROUNDNESS=1' -D 'HOLES=5' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="double"' -D 'DEBUG=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h6double.stl -D 'ROUNDNESS=1' -D 'HOLES=6' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="double"' -D 'DEBUG=false' ../frame.scad &
~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/frame_o1t4h7double.stl -D 'ROUNDNESS=1' -D 'HOLES=7' -D 'THICKNESS=4' -D 'HOLE_SEPARATION="double"' -D 'DEBUG=false' ../frame.scad &
wait

# Balls.
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/ball_r8.5o0t2hr2.5hnr0.5.stl -D 'ROUNDNESS=0' -D 'THICKNESS=2' -D 'RADIO=8.5' -D 'HOLE_RADIO=2.5' -D 'HOLE_NOTCH_RADIO=0.5' -D 'DEBUG=false' ../ball.scad &
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/ball_r9o0t2hr2.5hnr0.5.stl -D 'ROUNDNESS=0' -D 'THICKNESS=2' -D 'RADIO=9' -D 'HOLE_RADIO=2.5' -D 'HOLE_NOTCH_RADIO=0.5' -D 'DEBUG=false' ../ball.scad &


# Joints.
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/joint_o1h60t3r11sw1sf25.stl -D 'ROUNDNESS=1' -D 'HEIGHT=60' -D 'THICKNESS=3' -D 'RADIO=11' -D 'SLOT_WIDTH=1' -D 'SLOT_OFFSET=25' -D 'DEBUG=false' ../joint.scad &


# Links.
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/link_r2.5h40nr0.6sw0.5sh10.stl -D 'RADIO=2.5' -D 'HEIGHT=40' -D 'NOTCH_RADIO=0.6' -D 'SLOT_WIDTH=0.5' -D 'SLOT_HEIGHT=10' -D 'DEBUG=false' ../link.scad &

# Supports.
#~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o ../stl/support_l80t2lr2.5lsh10g2fl8nr0.5.stl -D 'LENGTH=80' -D 'THICKNESS=2' -D 'LINK_RADIO=2.5' -D 'LINK_SLOT_HEIGHT=10' -D 'GAP=2' -D 'FLANGE_LENGTH=8' -D 'NOTCH_RADIO=0.5' -D 'DEBUG=false' ../support.scad &
wait
