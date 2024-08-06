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
                    withCredentials([file(credentialsId: 'minikube-kubeconfig-file', variable: 'KUBECONFIG')]) {
                    bat '''
                        kubectl --kubeconfig=%KUBECONFIG% config set-context minikube
                        kubectl --kubeconfig=%KUBECONFIG% apply -f k8/deployment.yaml --validate=false
                    '''
                    }
                }
            }
        }

    post {
        always {
            cleanWs()
        }
    }
}
