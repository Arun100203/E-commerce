pipeline {
    agent any
    stages {
        stage('Stage 1') {
            steps {
                echo 'Build start'
            }
        }
        stage('Rspec'){
            steps{
                echo 'Rspec begin'
            }
            stages{
                stage('Paralle test'){
                    steps{
                        script{
                            echo 'if docker enabled then we can check this stage'
                        }
                    }
                }
            }
        }
    }
}
