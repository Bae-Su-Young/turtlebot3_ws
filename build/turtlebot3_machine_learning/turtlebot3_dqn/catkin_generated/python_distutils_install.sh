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

echo_and_run cd "/home/piai/turtlebot3_ws/src/turtlebot3_machine_learning/turtlebot3_dqn"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/piai/turtlebot3_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/piai/turtlebot3_ws/install/lib/python2.7/dist-packages:/home/piai/turtlebot3_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/piai/turtlebot3_ws/build" \
    "/usr/bin/python2" \
    "/home/piai/turtlebot3_ws/src/turtlebot3_machine_learning/turtlebot3_dqn/setup.py" \
     \
    build --build-base "/home/piai/turtlebot3_ws/build/turtlebot3_machine_learning/turtlebot3_dqn" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/piai/turtlebot3_ws/install" --install-scripts="/home/piai/turtlebot3_ws/install/bin"
