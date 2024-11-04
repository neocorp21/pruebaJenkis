pipeline {
    agent any
    stages {
         stage('Build') {
             steps {
                 script {
                     try {
                         def output = sh(script: 'mvn clean package', returnStdout: true).trim()
                         echo "Build output: ${output}"
                         // Listar los archivos en el directorio target
                         sh 'ls -l target/'
                     } catch (Exception e) {
                         currentBuild.result = 'FAILURE'
                         // Mensaje de error en rojo
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
                        // Mensaje de error en rojo
                        error "\u001B[31mUnit tests failed: ${e.message}\u001B[0m"
                    }
                }
            }
        }

       stage('Deploy') {
           steps {
               script {
                   // Cambia 'DemoJenkis.jar' por el nombre correcto del JAR
                   def jarName = 'DemoJenkis-0.0.1-SNAPSHOT.jar' // Reemplaza esto
                   def destination = '/var/jenkins_home/deploy/'
                   try {
                       def output = sh(script: "cp target/${jarName} ${destination}", returnStdout: true).trim()
                       echo "Deployment output: ${output}"
                   } catch (Exception e) {
                       currentBuild.result = 'FAILURE'
                       // Mensaje de error en rojo
                       error "\u001B[31mDeployment failed: ${e.message}\u001B[0m"
                   }
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
