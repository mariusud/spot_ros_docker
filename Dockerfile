FROM ros:noetic-ros-core

ENV DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y \
  software-properties-common \
  git \ 
  build-essential \
  python3-osrf-pycommon \
  python3-catkin-tools \
  python3-catkin-pkg \ 
  python3-rosdep \ 
  python3-pip \ 
  ros-noetic-catkin \
  qttools5-dev && \
  add-apt-repository ppa:deadsnakes/ppa &&\ 
  apt-get install -y \
  libpython3.6 \ 
  libpython3.6-dev && \
  rm -rf /var/lib/apt/lists/*

RUN \ 
  pip3 install \
  cython \
  bosdyn-client \
  bosdyn-mission \
  bosdyn-api \
  bosdyn-core \
  empy

RUN mkdir -p catkin_ws/src

ENV ROS_WS /opt/ros_ws

RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO && \
  mkdir -p $ROS_WS/src

WORKDIR $ROS_WS

RUN cd src ; git clone https://github.com/clearpathrobotics/spot_ros.git && \
  git clone https://github.com/ros/geometry2 --branch 0.7.5 && \
  cd .. ;  apt-get update -y && \
  . /opt/ros/$ROS_DISTRO/setup.sh && \
  rosdep install --from-paths $ROS_WS/src --ignore-src -r -y && \ 
  rm -rf /var/lib/apt/lists/* && \
  catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENV PYTHONUNBUFFERED=1

RUN mkdir /bagfiles

ENTRYPOINT ["/entrypoint.sh"]

CMD roslaunch spot_driver driver.launch