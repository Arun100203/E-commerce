pipeline {
    agent any
    stages {
        stage('Stage 1') {
            steps {
                echo 'Build start'
            }
        }

        stage('Stage 2 - Rspec'){
            steps{
                echo 'Rspec begin'
            }
            steps{
                 script {
                    container('arun-rspec') {
                        sh "rspec"
                    }
                }
            }
        }
    }
}
