#!/bin/sh

BUILD_ROOT=/tmp/build

if [ ! -d /data ] || [ ! "$(ls -A /data/)" ]; then
    echo "No volume with project data mounted to /data"
    exit
fi

mkdir ${BUILD_ROOT}
mkdir ${BUILD_ROOT}/data/
cp /data/* ${BUILD_ROOT}/data/
cd ${BUILD_ROOT}

if [ -f ${BUILD_ROOT}/data/requirements.txt ]; then
    virtualenv .
    . ${BUILD_ROOT}/bin/activate
    pip install -r ${BUILD_ROOT}/data/requirements.txt
    cd ${BUILD_ROOT}/lib/python2.7/site-packages
    zip -r9 ${BUILD_ROOT}/out.zip *
else
    echo "requirements.txt not found!"
fi

cd ${BUILD_ROOT}/data
zip -r9 ${BUILD_ROOT}/out.zip * -x "out.zip" # to avoid recursive packaging if run multiple times

cp ${BUILD_ROOT}/out.zip /data/