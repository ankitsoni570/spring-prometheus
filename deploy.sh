gcloud app create --project=concrete-crow-244606 --region=us-central
gcloud app deploy ./app.yaml --version v1 --image-url=gcr.io/concrete-crow-244606/test-jenkins
gcloud app deploy ./app-v2.yaml --version v2 --image-url=gcr.io/concrete-crow-244606/test-jenkins
gcloud app services set-traffic default --splits v2=70,v1=30 --split-by IP
