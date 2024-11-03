pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }

        }
        stage('Deploy') {
            steps {
                sh 'cp target/DemoJenkis.jar /var/jenkins_home/deploy/'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
