#! /bin/bash
#ganesh.pise - Code to release final version in production

gcloud app services set-traffic prodenv --splits ${BUILD_NUMBER}=100 --split-by ip
#stop non serving versions
#TOSTOPPRODVERSION=`gcloud app versions list | grep prodenv | grep '0.00' | awk {'print $2;'}
#gcloud app versions stop ${TOSTOPPRODVERSION} --service prodenv -q

#stop non required versions
#gcloud app versions list | grep prodenv | grep SERVING | grep -v VERSION.ID| grep '0.00' | awk '{ print $2};'|xargs -L1 gcloud app versions stop

