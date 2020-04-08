#To stop versions serving 0% traffic - just to handle test scenario
#gcloud app versions list | grep prodenv | grep SERVING | grep -v VERSION.ID| grep 0.00 | awk '{ print $2};'|xargs -L1 gcloud app versions stop

PRODVERSION=`gcloud app versions list | grep prodenv | grep SERVING | grep 1.00 | awk {'print $2;'}`
echo "ExProd Version is " ${PRODVERSION}
gcloud app deploy ./app-v2.yaml --version ${BUILD_NUMBER} --image-url=gcr.io/infosys-gcp-demo-project/appenginecanary4spring --no-promote

echo "New Version is " ${BUILD_NUMBER}
gcloud app services set-traffic prodenv --splits ${PRODVERSION}=0.90,${BUILD_NUMBER}=0.10 --split-by ip

#Ganesh - Stopping and deleting QA version in this POC, In live scenario this QA environment will be kept to fix prod bugs
QAVERSION=`gcloud app versions list | grep testenv | awk {'print $2;'}`
#gcloud app versions stop $QAVERSION --service testenv -q
