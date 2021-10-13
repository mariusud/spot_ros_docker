# spot_ros_docker
A docker container for Clearpath' Spot package in ROS **noetic**

link to the package is [here](https://github.com/clearpathrobotics/spot_ros)

The following commands assume that your working directory is in the root folder of this repository.

## Build & Run Container

To build and run the docker container, see the `run.sh` file.

## Bagging

In another terminal, write the following to record all data to a rosbag:
```
docker exec -it spot-ros-container /bin/bash
source /entrypoint.sh && cd /bagfiles && rosbag record -a
```
Via volume mounts the bagfile is now available in the `bagfiles` subfolder in this repository's folder on the host computer.