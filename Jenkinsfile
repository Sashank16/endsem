	agent any
	    environment {
	        DOCKER_HUB_REPO = 'sashank16/node-microservice'
	        BLUE_ENV = 'blue_env'
	        GREEN_ENV = 'green_env'
	    }
	    stages {
	        stage('Build') {
	            steps {
	                script {
	                    docker.build("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
	                }
	            }
	        }
	        stage('Deploy to Blue') {
	            steps {
	                script {
	                    def blueContainer = docker.image("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
	                    // Use double quotes to interpolate the variable
	                    blueContainer.run("-d -p 3001:3000 --name ${env.BLUE_ENV}")
	                }
	            }
	        }
	        stage('Test Blue') {
	            steps {
	                script {
	                    echo 'Running tests on Blue environment...'
	                }
	            }
	        }
	        stage('Deploy to Green') {
	            steps {
	                script {
	                    def greenContainer = docker.image("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
	                    // Use double quotes to interpolate the variable
	                    greenContainer.run("-d -p 3002:3000 --name ${env.GREEN_ENV}")
	                }
	            }
	        }
	        stage('Test Green') {
	            steps {
	                script {
	                    echo 'Running tests on Green environment...'
	                }
	            }
	        }
	        stage('Cleanup') {
	            steps {
	                script {
	                    // Use double quotes to interpolate the variable
	                    sh "docker rm -f ${env.BLUE_ENV} || true"
	                    sh "docker rm -f ${env.GREEN_ENV} || true"
	                }
	            }
	        }
	    }
	
