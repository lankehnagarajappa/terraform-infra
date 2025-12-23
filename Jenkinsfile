pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        // SCM checkout is already done automatically
        stage('Terraform Init') {
            steps {
                sh '''
                  rm -rf .terraform
                  terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var="key_name=terraform-key"'
            }
        }

        stage('Approval') {
            steps {
                input message: "Approve Terraform Apply?"
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve -var="key_name=terraform-key"'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

