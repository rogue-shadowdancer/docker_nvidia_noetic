FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 

# Install packages
RUN apt update && apt install -y \
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
tcl tk expect aria2 net-tools;

RUN export https_proxy=http://10.200.13.85:3128 && http_proxy=http://10.200.13.85:3128

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
sudo apt-get install ros-$ROS_DISTRO-octomap* \
python-is-python3 \
ros-$ROS_DISTRO-dynamic-edt-3d \
ros-$ROS_DISTRO-gazebo* ;

RUN rosdep init
RUN rosdep update  

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
