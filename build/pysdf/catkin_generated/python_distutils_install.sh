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
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/florence/Takin-2/Takin/src/pysdf"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/florence/Takin-2/Takin/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/florence/Takin-2/Takin/install/lib/python2.7/dist-packages:/home/florence/Takin-2/Takin/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/florence/Takin-2/Takin/build" \
    "/usr/bin/python" \
    "/home/florence/Takin-2/Takin/src/pysdf/setup.py" \
    build --build-base "/home/florence/Takin-2/Takin/build/pysdf" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/florence/Takin-2/Takin/install" --install-scripts="/home/florence/Takin-2/Takin/install/bin"
