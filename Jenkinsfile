pipeline {
    agent any

    environment {
        JAR_NAME = 'DemoJenkis-0.0.1-SNAPSHOT.jar'
        DESTINATION = '/var/jenkins_home/deploy/'
        DOCKER_IMAGE = 'demo-jenkins-image'
        CONTAINER_NAME = 'demo-jenkins-container'
    }

    stages {
        stage('Check Docker') {
            steps {
                script {
                    try {
                        sh 'docker --version'
                        echo "Docker is installed."
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "\u001B[31mDocker is not installed or not running: ${e.message}\u001B[0m"
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        def output = sh(script: 'mvn clean package', returnStdout: true).trim()
                        echo "Build output: ${output}"
                        sh 'ls -l target/'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "\u001B[31mBuild failed: ${e.message}\u001B[0m"
                    }
                }
            }
        }

        stage('Unit Tests') {
            steps {
                script {
                    try {
                        def output = sh(script: 'mvn test', returnStdout: true).trim()
                        echo "Unit test output: ${output}"
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "\u001B[31mUnit tests failed: ${e.message}\u001B[0m"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    try {
                        sh "mkdir -p ${DESTINATION}" // Crear el directorio de despliegue
                        def output = sh(script: "cp target/${JAR_NAME} ${DESTINATION}", returnStdout: true).trim()
                        echo "Deployment output: ${output}"
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "\u001B[31mDeployment failed: ${e.message}\u001B[0m"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        sh "docker build -t ${DOCKER_IMAGE} ."
                        echo "Docker image ${DOCKER_IMAGE} built successfully."
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "\u001B[31mFailed to build Docker image: ${e.message}\u001B[0m"
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    try {
                        // Detener y eliminar contenedor existente
                        sh "docker stop ${CONTAINER_NAME} || true"
                        sh "docker rm ${CONTAINER_NAME} || true"

                        // Ejecutar el contenedor en segundo plano
                        sh "docker run -d --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                        echo "Docker container ${CONTAINER_NAME} is running."
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "\u001B[31mFailed to run Docker container: ${e.message}\u001B[0m"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            // Detener y eliminar el contenedor después de la ejecución
            sh "docker stop ${CONTAINER_NAME} || true"
            sh "docker rm ${CONTAINER_NAME} || true"
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
