pipeline {
    agent any
    
    environment {
        SERVICE_NAME = "nginx"
        ORGANIZATION_NAME = "muhammadadel8"
        DOCKERHUB_USERNAME = "muhammadadel8"
        REPOSITORY_TAG = "${DOCKERHUB_USERNAME}/${ORGANIZATION_NAME}-${SERVICE_NAME}:${BUILD_ID}"
    }
   
    stages {
        stage ('Build and Push Image') {
            steps {
                 withDockerRegistry([credentialsId: 'docker-hub', url: ""]) {
                   sh 'docker build -t ${REPOSITORY_TAG} .'
                   sh 'docker push ${REPOSITORY_TAG}'          
            }
          }
       }
        stage ('Deploy to Cluster') {
            steps {
                sh "cat deploy.yml | sed 's/${REPOSITORY_TAG}/${REPOSITORY_TAG}/g' | kubectl apply -f deploy.yml "
                }
            }
        }
    }
