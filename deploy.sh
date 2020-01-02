gcloud app create --project=infosys-gcp-demo-project --region=us-central
gcloud app deploy ./app.yaml --version v11 --image-url=gcr.io/infosys-gcp-demo-project/test-jenkins
gcloud app deploy ./app-v2.yaml --version v12 --image-url=gcr.io/infosys-gcp-demo-project/test-jenkins --no-promote
gcloud app services set-traffic default --splits v11=60,v12=40 --split-by ip
