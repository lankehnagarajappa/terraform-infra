pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/lankehnagarajappa/terraform-infra.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
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

        stage('Terraform Apply') {
            steps {
                //input message: "Do you want to apply Terraform changes?"
                sh 'terraform apply -auto-approve -var="key_name=terraform-key"'
            }
        }
    }
}

