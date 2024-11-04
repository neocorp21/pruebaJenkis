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

        stage('Run Application') {
            steps {
                script {
                    def jarPath = "/var/jenkins_home/deploy/DemoJenkis-0.0.1-SNAPSHOT.jar"
                    try {
                        // Ejecuta el JAR en segundo plano
                        sh "nohup java -jar ${jarPath} > app.log 2>&1 &"
                        echo "Application is running. Logs can be found in app.log."
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "\u001B[31mFailed to run application: ${e.message}\u001B[0m"
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
