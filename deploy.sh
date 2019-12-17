gcloud app create --project=concrete-crow-244606 --region=us-central
gcloud app deploy ./app.yaml --version v1 --image-url=gcr.io/concrete-crow-244606/test-jenkins
gcloud app services set-traffic default --splits v1=70 --split-by ip
gcloud app deploy ./app-v2.yaml --version v2 --image-url=gcr.io/concrete-crow-244606/test-jenkins
gcloud app services set-traffic default --splits v1=70,v2=30 --split-by ip
