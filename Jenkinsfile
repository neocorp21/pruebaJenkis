pipeline {
    agent any
    stages {
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
                        // Construye la imagen de Docker
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
                                // Nombre de la imagen Docker a crear
                                def dockerImage = 'demo-jenkins-image'

                                // Comando para construir la imagen usando el Dockerfile
                                sh "docker build -t ${dockerImage} ."

                                // Mensaje de éxito
                                echo "Docker image ${dockerImage} built successfully."
                            } catch (Exception e) {
                                // Manejo de errores en caso de fallo en la construcción
                                currentBuild.result = 'FAILURE'
                                error "\u001B[31mFailed to build Docker image: ${e.message}\u001B[0m"
                            }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
            // Opcional: detener y eliminar el contenedor después de la ejecución
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
