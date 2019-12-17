gcloud app create --project=concrete-crow-244606 --region=us-central
gcloud app deploy ./app.yaml --version v11 --image-url=gcr.io/concrete-crow-244606/test-jenkins
gcloud app deploy ./app-v2.yaml --version v12 --image-url=gcr.io/concrete-crow-244606/test-jenkins --no-promote
gcloud app services set-traffic default --splits v11=70,v12=30 --split-by ip
