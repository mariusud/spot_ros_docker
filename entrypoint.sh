#!/bin/bash

source /opt/ros/noetic/setup.bash
catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so

source /home/catkin_ws/devel/setup.bash
echo "running spot driver"
roslaunch spot_driver driver.launch