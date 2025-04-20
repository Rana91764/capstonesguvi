pipeline {
    agent any
 
    environment {
        DOCKER_DEV_REPO = 'rana1993/dev_guvi'
        DOCKER_PROD_REPO = 'rana1993/prod_guvi'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        BRANCH_NAME = "${env.BRANCH_NAME}"
    }
 
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
 
        stage('Execute Permission to Scripts') {
            steps {
                sh '''
                    chmod +x build.sh
                    chmod +x deploy.sh
                '''
            }
        }
 
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'a6d5c5b1-3dc4-4e62-8d46-0b3901840a47',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }
 
        stage('Build & Push Docker Image') {
            steps {
                sh './build.sh'
            }
        }
 
        stage('Tag & Push Docker Image') {
            steps {
                sh '''
                    scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Jenkinskeypair.pem deploy.sh ubuntu@ip-172-31-2-62:/home/ubuntu/
                    ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Jenkinskeypair.pem ubuntu@ip-172-31-2-62 "chmod +x deploy.sh && BRANCH_NAME=${BRANCH_NAME} bash deploy.sh"
                '''
            }
        }
 
        stage('Deploy') {
            steps {
                echo "Trigger deployment based on branch: ${env.BRANCH_NAME}"
            }
        }
    }
}
 
 