pipeline {
   agent any

   tools {
      // Install the Maven version configured as "M3" and add it to the path.
      maven "mvn"
      jdk "jdk"
   }

   stages {
      stage('SCM Checkout') {
         steps {
            println "============= SCM Checkout =============="
            git 'https://github.com/ankitsoni570/spring-prometheus.git'
         }
      }
      stage('Code Inspection'){
          steps {
            println "============== SonarQube Scanning ======================="
            withSonarQubeEnv('sonarqube') {
                sh 'mvn clean package sonar:sonar'
            }
         }
      }
      stage('Build, Package & JUnit'){
          steps {
            println "============== Build, Package & JUnit ================"
            sh "mvn clean install -Dmaven.test.failure.ignore=true"
            sh "docker build --tag sample ."
            sh "docker tag sample gcr.io/infosys-gcp-demo-project/test-jenkins:latest"
         }
      }
      stage('Deploy'){
          steps {
            println "============== Deploy and Split Traffic=================="
            withCredentials([file(credentialsId: "gcp-key", variable: 'GOOGLE_APPLICATION_CREDENTIALS')])
        	{
        		sh("gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS")
        		sh("gcloud docker -- push gcr.io/infosys-gcp-demo-project/test-jenkins:latest")
        		sh("sh deploy.sh")
        	}
         }
      }
      stage('Functional & Performance Test'){
          steps {
            println "=========== Functional and Performance Test ==============="
         }
      }
      stage('A/B Testing'){
          steps {
              input message: "Functional & Performance Testing done. Should we continue?"
              println "=========== A/B Testing ==============="
         }
      }
      stage('Release'){
          steps {
              input message: "A/B Testing done. Should we continue?"
              withCredentials([file(credentialsId: "gcp-key", variable: 'GOOGLE_APPLICATION_CREDENTIALS')])
            	{
            		sh("gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS")
            		sh("gcloud app services set-traffic default --splits v11=100 --split-by ip")
            	}
         }
      }
   }
}
