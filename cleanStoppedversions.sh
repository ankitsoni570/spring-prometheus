#ganesh.pise - removes stopped versions from all environments
#for versions serving 0% traffic
gcloud app versions list | grep SERVING | grep -v VERSION.ID| grep '0.00' | awk '{ print $2};'|xargs -L1 gcloud app versions delete
gcloud app versions list | grep SERVING | grep -v VERSION.ID| grep '0.00' | awk '{ print $2};'|xargs -L1 gcloud app versions stop
gcloud app versions list | grep STOPPED | grep -v VERSION.ID |grep '0.00' | awk '{ print $2};'|xargs -L1 gcloud app versions delete
#for stopped versions serviing traffic more than 0 - yet to handle
