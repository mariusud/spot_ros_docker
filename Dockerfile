FROM ros:noetic-ros-core
WORKDIR /home/
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
  libpython3.6-dev 

RUN \ 
  pip3 install \
  cython \
  bosdyn-client \
  bosdyn-mission \
  bosdyn-api \
  bosdyn-core \
  empy

RUN mkdir -p catkin_ws/src
COPY ./ catkin_ws/src/spot_ros_docker

WORKDIR /home/catkin_ws/src
RUN git clone https://github.com/clearpathrobotics/spot_ros.git
RUN git clone https://github.com/ros/geometry2 --branch 0.7.5

WORKDIR /home/catkin_ws/
RUN \
  rosdep init && \
  rosdep update && \
  rosdep install --from-paths ./src --ignore-packages-from-source --rosdistro noetic -y

CMD /home/catkin_ws/src/spot_ros_docker/entrypoint.sh
