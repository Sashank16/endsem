1.	agent any
2.	    environment {
3.	        DOCKER_HUB_REPO = 'sashank16/node-microservice'
4.	        BLUE_ENV = 'blue_env'
5.	        GREEN_ENV = 'green_env'
6.	    }
7.	    stages {
8.	        stage('Build') {
9.	            steps {
10.	                script {
11.	                    docker.build("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
12.	                }
13.	            }
14.	        }
15.	        stage('Deploy to Blue') {
16.	            steps {
17.	                script {
18.	                    def blueContainer = docker.image("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
19.	                    // Use double quotes to interpolate the variable
20.	                    blueContainer.run("-d -p 3001:3000 --name ${env.BLUE_ENV}")
21.	                }
22.	            }
23.	        }
24.	        stage('Test Blue') {
25.	            steps {
26.	                script {
27.	                    echo 'Running tests on Blue environment...'
28.	                }
29.	            }
30.	        }
31.	        stage('Deploy to Green') {
32.	            steps {
33.	                script {
34.	                    def greenContainer = docker.image("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
35.	                    // Use double quotes to interpolate the variable
36.	                    greenContainer.run("-d -p 3002:3000 --name ${env.GREEN_ENV}")
37.	                }
38.	            }
39.	        }
40.	        stage('Test Green') {
41.	            steps {
42.	                script {
43.	                    echo 'Running tests on Green environment...'
44.	                }
45.	            }
46.	        }
47.	        stage('Cleanup') {
48.	            steps {
49.	                script {
50.	                    // Use double quotes to interpolate the variable
51.	                    sh "docker rm -f ${env.BLUE_ENV} || true"
52.	                    sh "docker rm -f ${env.GREEN_ENV} || true"
53.	                }
54.	            }
55.	        }
56.	    }
57.	}
