FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 

# Install packages
RUN apt update && apt install -y \
build-essential \
libgl1-mesa-dev \
libglew-dev \
libsdl2-dev \
libsdl2-image-dev \
libglm-dev \
libfreetype6-dev \
libglfw3-dev \
libglfw3 \
libglu1-mesa-dev \
freeglut3-dev \
python3-pip \
lsb-release \
git \
neovim \
tmux \
wget \
curl \
htop \
libssl-dev \
build-essential \
dbus \ 
dbus-x11 \
mesa-utils \
libgl1-mesa-glx \
software-properties-common \
tmux \
psmisc \
screen \
python-is-python3 \
x11-apps \
tcl tk expect aria2 net-tools;

RUN pip install numpy==1.24 open3d alphashape ortools

RUN git config --global credential.helper store

# Install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt update && \
    apt install -y ros-noetic-desktop-full python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential


# Configure ROS
ENV ROS_DISTRO noetic

RUN apt update && apt install -y \
python3-wstool python3-catkin-tools python3-empy \
protobuf-compiler libgoogle-glog-dev \
ros-$ROS_DISTRO-control-toolbox \
ros-$ROS_DISTRO-octomap-msgs \
ros-$ROS_DISTRO-octomap-ros \
ros-$ROS_DISTRO-mavros \
ros-$ROS_DISTRO-mavros-msgs \
ros-$ROS_DISTRO-rviz-visual-tools \
ros-$ROS_DISTRO-gazebo-plugins \
ros-$ROS_DISTRO-octomap* \
ros-$ROS_DISTRO-dynamic-edt-3d \
ros-$ROS_DISTRO-gazebo* ;

RUN chsh -s /bin/bash

RUN echo "export https_proxy=http://10.200.13.85:3128 && http_proxy=http://10.200.13.85:3128" >> /root/.bashrc
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc

RUN export https_proxy=http://10.200.13.85:3128 && http_proxy=http://10.200.13.85:3128
RUN exec bash && source /opt/ros/noetic/setup.bash
RUN rosdep init
RUN rosdep update  
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
