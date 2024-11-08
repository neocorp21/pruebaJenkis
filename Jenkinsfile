pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'demo-jenkins-app:0.0.1-SNAPSHOT'
    }

    stages {
        stage('Clonar Código') {
            steps {
                // Clonar el repositorio desde GitHub
                git 'https://github.com/neocorp21/pruebaJenkis.git'
            }
        }

        stage('Construir JAR') {
            steps {
                script {
                    // Ejecutar Maven para construir el JAR
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                script {
                    // Construir la imagen Docker usando el Dockerfile
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Desplegar Aplicación') {
            steps {
                script {
                    // Detener y eliminar el contenedor si ya está en ejecución
                    sh 'docker ps -q -f "name=demo-jenkins-app" | xargs -r docker stop | xargs -r docker rm'

                    // Ejecutar el contenedor de la nueva imagen
                    sh 'docker run -d -p 8082:8082 --name demo-jenkins-app ${DOCKER_IMAGE}'
                }
            }
        }
    }

    post {
        always {
            // Limpiar imágenes Docker antiguas si es necesario
            sh 'docker system prune -af'
        }

        success {
            echo '¡Pipeline ejecutado con éxito!'
        }

        failure {
            echo '¡Hubo un error durante la ejecución del pipeline!'
        }
    }
}
