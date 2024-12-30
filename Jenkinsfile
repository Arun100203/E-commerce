pipeline {
    agent any
    stages {
        stage('Stage 1') {
            steps {
                echo 'Build start'
            }
        }
        stage('Rspec') {
            steps {
                echo 'Rspec begin'
            }
        }
        stage('Parallel Test') {
            // when {
            //     expression { // Replace with your condition for checking Docker
            //         // Example condition for demonstration:
            //         fileExists('/usr/bin/docker')
            //     }
            // }
            steps {
                echo 'If Docker is enabled, this stage will execute'
            }
        }
    }
}
