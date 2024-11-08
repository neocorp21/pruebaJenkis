pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "demo-jenkins-app"  // Nombre base para la imagen Docker
        DOCKER_TAG = "0.0.1-SNAPSHOT"     // Etiqueta para la imagen Docker
    }
    stages {
        stage('Clonar Código') {
            steps {
                // Clonar el repositorio de código
                git url: 'https://github.com/neocorp21/pruebaJenkis.git', branch: 'main'
            }
        }
        stage('Construir JAR') {
            steps {
                script {
                    // Ejecuta mvn clean package para construir el archivo JAR
                    sh 'mvn clean package'

                    // Verifica si el archivo JAR existe en target/
                    sh 'ls -l target/demo-jenkins-app-0.0.1-SNAPSHOT.jar'
                }
            }
        }
        stage('Construir Imagen Docker') {
            steps {
                script {
                    // Construir la imagen Docker para la aplicación Spring Boot
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }
        stage('Desplegar Aplicación') {
            steps {
                script {
                    // Detener y eliminar el contenedor anterior, si existe
                    sh 'docker stop demo-jenkins-app || true && docker rm demo-jenkins-app || true'

                    // Ejecutar la nueva versión de la aplicación en el puerto 8082
                    sh "docker run -d --name demo-jenkins-app -p 8082:8080 ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
    }
    post {
        always {
            // Esto se ejecutará siempre, sin importar si el pipeline falla o tiene éxito
            echo 'Pipeline ejecutado con éxito'
        }
        success {
            // Si el pipeline tiene éxito, puedes enviar notificaciones o realizar otras acciones
            echo 'Despliegue exitoso!'
        }
        failure {
            // Si el pipeline falla, puedes enviar notificaciones de error
            echo '¡Hubo un error durante el despliegue!'
        }
    }
}
