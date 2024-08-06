pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/dsharma143/projCert.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("deepaksharma143/projcert:${env.BUILD_ID}")
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                    bat '''
                        kubectl apply -f k8/deployment.yaml --validate=false
                    '''
                }
            }
        }

    post {
        always {
            cleanWs()
        }
    }
}
