pipeline {
    agent any

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
                    def jarName = 'DemoJenkis-0.0.1-SNAPSHOT.jar'
                    def destination = '/var/jenkins_home/deploy/'
                    try {
                        sh "mkdir -p ${destination}" // Crear el directorio de despliegue
                        def output = sh(script: "cp target/${jarName} ${destination}", returnStdout: true).trim()
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
                        def dockerImage = 'demo-jenkins-image'
                        sh "docker build -t ${dockerImage} ."
                        echo "Docker image ${dockerImage} built successfully."
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
                        def dockerImage = 'demo-jenkins-image'
                        def containerName = 'demo-jenkins-container'

                        // Detener y eliminar contenedor existente
                        sh "docker stop ${containerName} || true"
                        sh "docker rm ${containerName} || true"

                        // Ejecutar el contenedor en segundo plano
                        sh "docker run -d --name ${containerName} ${dockerImage}"
                        echo "Docker container ${containerName} is running."
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
            sh "docker stop demo-jenkins-container || true"
            sh "docker rm demo-jenkins-container || true"
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
