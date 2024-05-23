pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Your Docker Hub credentials ID
        IMAGE_NAME = 'your-docker-username/your-image-name'
        AWS_CREDENTIALS_ID = 'aws-credentials' // Your AWS credentials ID
        EC2_INSTANCE_IP = 'your-ec2-instance-ip'
        SSH_PRIVATE_KEY = 'ssh-private-key-id' // Your SSH private key ID in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from your version control
                git 'https://github.com/taukirattar/ATM.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        def app = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                        app.push()
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    sshagent(credentials: [SSH_PRIVATE_KEY]) {
                        sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${EC2_INSTANCE_IP} '
                        docker pull ${IMAGE_NAME}:latest &&
                        docker stop react-app || true &&
                        docker rm react-app || true &&
                        docker run -d --name react-app -p 80:80 ${IMAGE_NAME}:latest
                        '
                        """
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
