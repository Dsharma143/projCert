pipeline {
    agent any

    environment {
        ANSIBLE_HOST = "52.91.26.180" // AWS EC2 instance
        DOCKER_IMAGE = "deepaksharma143/projcert:latest"
        DOCKERHUB_USERNAME = "deepaksharma143"
        DOCKERHUB_PASSWORD = "Shiv@1431"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/dsharma143/projCert.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh 'echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin'
                    dockerImage.push()
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                script {
                    // Running Ansible Playbook directly on the EC2 instance
                    sh '''
                        ansible-playbook -i ${ANSIBLE_HOST}, -u ec2-user deploy.yml --extra-vars "docker_image=${DOCKER_IMAGE}"
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
