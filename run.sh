#!/bin/bash
docker build . -t spot-ros
docker run --rm -it --name spot-ros-container --network=host -v "$PWD/bagfiles":/bagfiles spot-ros