#! /system/bin/sh
MODDIR=${0%/*}
echo "launching configurator..."
su -c sh $MODDIR/common/configurator
