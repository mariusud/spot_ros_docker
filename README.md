# spot_ros_docker
A docker container for Clearpath' Spot package in ROS **noetic**

link to the package is [here](https://github.com/clearpathrobotics/spot_ros)

## Installation
To set up the Spot ROS driver 
```
./run.sh
docker run spotrosdocker
```

In another terminal, write the following to record all data to a rosbag:
```
docker exec -it <container_name> /bin/bash

```