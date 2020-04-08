#!/bin/bash

PRODVERSION=`gcloud app versions list | grep prodenv | grep SERVING | grep 0.90 | awk {'print $2;'}`
gcloud app services set-traffic prodenv --splits ${PRODVERSION}=1.00 --split-by ip
