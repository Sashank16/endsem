pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Sashank16/endsem.git'
        DOCKER_IMAGE = 'node-microservice'
        BLUE_CONTAINER = 'node-microservice-blue'
        GREEN_CONTAINER = 'node-microservice-green'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        stage('Deploy to Blue or Green Environment') {
            steps {
                script {
                    def blueRunning = sh(script: "docker ps -q -f name=${BLUE_CONTAINER}", returnStatus: true) == 0
                    def greenRunning = sh(script: "docker ps -q -f name=${GREEN_CONTAINER}", returnStatus: true) == 0

                    if (blueRunning) {
                        // Stop the green container if running and start the new one there
                        sh "docker stop ${GREEN_CONTAINER} || true && docker rm ${GREEN_CONTAINER} || true"
                        sh "docker run -d --name ${GREEN_CONTAINER} -p 3000:3000 ${DOCKER_IMAGE}:latest"
                    } else {
                        // Stop the blue container if running and start the new one there
                        sh "docker stop ${BLUE_CONTAINER} || true && docker rm ${BLUE_CONTAINER} || true"
                        sh "docker run -d --name ${BLUE_CONTAINER} -p 3000:3000 ${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up old containers"
            sh "docker container prune -f"
        }
    }
}
