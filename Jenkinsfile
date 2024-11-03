pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    try {
                        sh 'mvn clean package'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "Build failed: ${e.message}"
                    }
                }
            }
        }
        stage('Unit Tests') {
            steps {
                script {
                    try {
                        sh 'mvn test'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "Unit tests failed: ${e.message}"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    try {
                        sh 'cp target/DemoJenkis.jar /var/jenkins_home/deploy/'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "Deployment failed: ${e.message}"
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
