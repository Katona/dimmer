#!/bin/sh

PACKAGE_NAME=flaskr-1.0.0-py3-none-any.whl
HOST=dimmer@magic-wand.local

rm -r dist
venv/bin/python3 setup.py bdist_wheel
scp dist/$PACKAGE_NAME $HOST:
ssh $HOST venv/bin/pip3 install -I $PACKAGE_NAME