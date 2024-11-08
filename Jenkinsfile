pipeline {
    agent any
    stages {
        stage('Clonar Código') {
            steps {
                // Clonar el repositorio de código
                git url: 'https://github.com/neocorp21/pruebaJenkis.git', branch: 'main'
            }
        }
        stage('Construir Imagen Docker') {
            steps {
                // Construir la imagen Docker para la aplicación Spring Boot
                sh 'docker build -t demo-jenkins-app:0.0.1-SNAPSHOT .'
            }
        }
        stage('Desplegar Aplicación') {
            steps {
                script {
                    // Detiene y elimina el contenedor anterior, si existe
                    sh 'docker stop demo-jenkins-app || true && docker rm demo-jenkins-app || true'

                    // Ejecuta la nueva versión en el puerto 8082
                    sh 'docker run -d --name demo-jenkins-app -p 8082:8080 demo-jenkins-app:0.0.1-SNAPSHOT'
                }
            }
        }
    }
}
