#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/shaenar/TFM_DeepLearning/src/turtlebot3_machine_learning_tfm/turtlebot3_dqn"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/shaenar/TFM_DeepLearning/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/shaenar/TFM_DeepLearning/install/lib/python2.7/dist-packages:/home/shaenar/TFM_DeepLearning/build/turtlebot3_dqn/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/shaenar/TFM_DeepLearning/build/turtlebot3_dqn" \
    "/usr/bin/python2" \
    "/home/shaenar/TFM_DeepLearning/src/turtlebot3_machine_learning_tfm/turtlebot3_dqn/setup.py" \
     \
    build --build-base "/home/shaenar/TFM_DeepLearning/build/turtlebot3_dqn" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/shaenar/TFM_DeepLearning/install" --install-scripts="/home/shaenar/TFM_DeepLearning/install/bin"
