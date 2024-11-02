# Dockerfile
FROM jenkins/jenkins:lts

# Instalar Maven
USER root
RUN apt-get update && apt-get install -y maven

# Cambiar de nuevo al usuario Jenkins
USER usuarioAdmin


pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building the project...'
                    sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    sh 'mvn test'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            cleanWs() // Limpia el workspace
        }
        success {
            echo 'Build and tests succeeded!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
