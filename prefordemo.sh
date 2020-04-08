#! /bin/bash

#script to start stopped versions on prod and test epp engine environment

gcloud app versions list| grep STOPPED | grep prodenv | grep -v VERSION.ID |grep '1.00' | awk '{ print $2};'|xargs -L1 gcloud app versions start
