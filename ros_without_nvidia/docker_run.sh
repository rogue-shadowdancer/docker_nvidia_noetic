CONTAINER_NAME="noetic_docker"
IMAGE_NAME="cwc_docker"
SHARED_DIR="/home/tianyi.zhang/ws/caric_dku/cwc_docker/shared_dir"
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

docker run -it \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="$XSOCK:$XSOCK:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --net=host \
    --gpus all \
    --volume="$SHARED_DIR:$SHARED_DIR" \
    --name=$CONTAINER_NAME \
    $IMAGE_NAME \
    bash

