#!/bin/sh

export SYSDIG_HOST_ROOT=/host

insmod /lib/sysdig-probe.ko

/bin/csysdig

rmmod /lib/sysdig-probe.ko