docker build --tag test .
docker tag test gcr.io/infosys-gcp-demo-project/spring-test-1
docker push gcr.io/infosys-gcp-demo-project/spring-test-1
