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
        stage("Install kubectl"){
            steps {
                sh """
                    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
                    chmod +x ./kubectl
                    ./kubectl version --client
                """
            }
        }
        stage ('Deploy to Cluster') {
            steps {
                sh "cat deploy.yml | sed 's/{{BUILD_NUMBER}}/$BUILD_NUMBER/g' | kubectl apply -f -"
                }
            }
        }
    }
