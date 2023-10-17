pipeline {
    agent any
    
    environment {
    	dockerImage = ''
    }
    
    stages {
        stage('Build Image') {
            steps {
                script {
                        dockerImage = docker.build("ashkumarkdocker/docker-e2e-automation")
                }
            }
        }
        stage('API Automation') {
        	agent {
                docker {
                    image 'ashkumarkdocker/docker-e2e-automation'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
            	sh 'mvn test -Dcucumber.filter.tags="@API"'
            }
        }
        stage('Docker Teardown') {
            steps {
                /* Tear down all containers */
                //sh 'docker stop $(docker ps -aq)'
            }
        }
	}

    post {
        always {
            cleanWs()
        }
    }
}