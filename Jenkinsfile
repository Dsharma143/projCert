pipeline {
    agent any

    environment {
        ANSIBLE_HOST = "52.91.26.180" // AWS EC2 instance
        DOCKER_IMAGE = "deepaksharma143/projcert:latest"
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
                    dockerImage.push()
                }
            }
        }

        stage('Run Ansible Playbook in Docker') {
            steps {
                script {
                    // Running Ansible Playbook in an Ansible Docker Container
                    docker.image('willhallonline/ansible:latest').inside {
                        sh '''
                            ansible-playbook -i ${ANSIBLE_HOST}, -u ec2-user deploy.yml --extra-vars "docker_image=${DOCKER_IMAGE}"
                        '''
                    }
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
