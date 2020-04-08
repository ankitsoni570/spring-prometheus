gcloud app create --project=infosys-gcp-demo-project --region=us-central
gcloud app deploy ./app-qa.yaml --version ${BUILD_NUMBER} --image-url=gcr.io/infosys-gcp-demo-project/appenginecanary4spring