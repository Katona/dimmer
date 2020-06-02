#!/bin/sh

PACKAGE_NAME=flaskr-1.0.0-py3-none-any.whl
HOST=dimmer@dimmer.local

rm -r dist
venv/bin/python3 setup.py bdist_wheel
scp dist/$PACKAGE_NAME $HOST:
ssh $HOST sudo systemctl stop dimmer.service
ssh $HOST venv/bin/pip3 install -I $PACKAGE_NAME
ssh $HOST sudo systemctl start dimmer.service
