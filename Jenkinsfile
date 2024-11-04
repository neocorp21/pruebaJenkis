pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    executeMavenCommand('clean package')
                    listFilesInDirectory('target/') // Listar archivos en el directorio target
                }
            }
        }

        stage('Unit Tests') {
            steps {
                script {
                    executeMavenCommand('test')
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    deployJar('DemoJenkis.jar', '/var/jenkins_home/deploy/')
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}

// Método para ejecutar comandos de Maven y manejar errores
def executeMavenCommand(command) {
    try {
        def output = sh(script: "mvn ${command}", returnStdout: true).trim()
        echo "Maven command output: ${output}"
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        error "Maven command '${command}' failed: ${e.message}"
    }
}

// Método para listar archivos en un directorio
def listFilesInDirectory(directory) {
    try {
        def output = sh(script: "ls -l ${directory}", returnStdout: true).trim()
        echo "Files in ${directory}:\n${output}"
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        error "Failed to list files in directory '${directory}': ${e.message}"
    }
}

// Método para desplegar el JAR
def deployJar(jarName, destination) {
    try {
        // Verificar si el archivo JAR existe
        sh "test -f target/${jarName}" // Lanza error si el archivo no existe
        def output = sh(script: "cp target/${jarName} ${destination}", returnStdout: true).trim()
        echo "Deployment output: ${output}"
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        error "Deployment of '${jarName}' to '${destination}' failed: ${e.message}"
    }
}
