gcloud app create --project=infosys-gcp-demo-project --region=us-central
gcloud app deploy ./app.yaml --version v1 --image-url=gcr.io/infosys-gcp-demo-project/test-jenkins
gcloud app deploy ./app-v2.yaml --version v2 --image-url=gcr.io/infosys-gcp-demo-project/test-jenkins --no-promote
gcloud app services set-traffic default --splits v1=70,v2=30 --split-by ip
