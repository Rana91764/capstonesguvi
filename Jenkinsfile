pipeline {
   agent any
 
   environment {
       DOCKER_DEV_REPO = 'rana1993/dev_guvi'
       DOCKER_PROD_REPO = 'rana1993/prod_guvi'
       IMAGE_TAG = "${env.BUILD_NUMBER}"
   }
 
   stages {
       stage('Checkout') {
           steps {
               checkout scm
           }
       }
 
 Stage ('execute permission to scripts'){
    steps{
        sh '''
        chmod +x build.sh
        chmod+x deploy.sh
        '''

    }

 }

 stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER" | docker login -u "rana1993" --password-stdin
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
               script {
                   if (env.BRANCH_NAME == 'dev') {
                       sh """
                           docker tag react-app $DOCKER_DEV_REPO:$IMAGE_TAG
                           docker push $DOCKER_DEV_REPO:$IMAGE_TAG
                       """
                   } else if (env.BRANCH_NAME == 'master') {
                       sh """
                           docker tag myapp $DOCKER_PROD_REPO:$IMAGE_TAG
                           docker push $DOCKER_PROD_REPO:$IMAGE_TAG
                       """
                   }
               }
           }
       }
 
       stage('Deploy') {
           steps {
               echo "Trigger deployment here based on branch: ${env.BRANCH_NAME}"
           }
       }
   }
}