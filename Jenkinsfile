pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'taukirattar/taukirapp'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/taukirattar/ATM.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image("${env.DOCKER_IMAGE}:${env.BUILD_ID}").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('', '') {
                        docker.image("${env.DOCKER_IMAGE}:${env.BUILD_ID}").run('-d -p 80:5000')
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
