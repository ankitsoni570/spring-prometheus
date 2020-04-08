pipeline {
   agent { 
        label 'slave-gcloud-spin'
   }

   tools {
      // Install the Maven version configured as and add it to the path.
      maven "mvn"
      jdk "jdk8"
   }

   stages {
      stage('SCM Checkout') {
         steps {
            println "============= SCM Checkout =============="
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
            sh "docker tag sample gcr.io/infosys-gcp-demo-project/appenginecanary4spring:latest"
         }
         post {
            success {
               junit '**/target/surefire-reports/TEST-*.xml'
               archiveArtifacts 'target/*.jar'
            }
         }
      }
      stage('Deploy on QA'){
          steps {
            println "============== Deploy and Split Traffic=================="
            withCredentials([file(credentialsId: "gcp-key", variable: 'GOOGLE_APPLICATION_CREDENTIALS')])
        	{
        		sh("gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS")
        		sh("gcloud docker -- push gcr.io/infosys-gcp-demo-project/appenginecanary4spring:latest")
        		sh("sh deploy-qa.sh")
        	}
         }
      }
      stage('Functional & Performance Test'){
          steps {
            println "=========== Functional and Performance Test ==============="
         }
      }
      stage('Canary Deployment'){
          steps {
            input message: "Functional & Performance Testing done. Should we continue?"
            println "=========== Blue Green Deployment ==============="
            withCredentials([file(credentialsId: "gcp-key", variable: 'GOOGLE_APPLICATION_CREDENTIALS')])
                {
                        sh("gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS")
                        sh("sh deploy.sh")
                }
         }
      }
      stage('Canary Testing'){
          steps {
              println "=========== Canary and A/B Testing ==============="
         }
      }
      stage('Release'){
         steps {
             script{
                 try{
                     input message: "A/B Testing done. Should we continue?"
                	 withCredentials([file(credentialsId: "gcp-key", variable: 'GOOGLE_APPLICATION_CREDENTIALS')])
                	 {
                	     sh("gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS")
                         sh("sh ./final-relese.sh")
                  	 }
                 }
                 catch (err){
                     sh("sh ./rollback.sh")
                 }
             }
         }
      }
   }
   post {
        success {
            sh("sh email-success.sh")
        }
        unstable {
            sh("sh email-unstable.sh")
        }
        failure {
            sh("sh email-failure.sh")
        }
    }
}
