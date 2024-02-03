pipeline {
    agent any

    stages {
        stage('Workspace Cleanup') {
            steps {
                cleanWs()
            }
        }

        stage('Clone GitHub repo') {
            steps {
                git 'https://github.com/Jagat45106/Jenkins-TF-Lab.git'
            }
        }
        stage('TFSec Scan') {
            steps {
                echo "================STARTING TFSEC STATIC SCAN=================="
                sh 'curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash'
                sh 'tfsec --version'
                echo "******SCANNING WITH TFSEC*******"
                sh 'tfsec -m HIGH -s --no-colour && tfsec -m CRITICAL -s --no-colour'
            }
        }
        stage('Terraform Plan') {
            when {
                allOf {
                    expression { params.TERRAFORM_ACTION == 'plan' }
                }
                any0f {
                      expression { params.ACCOUNT == 'dev' }
                      expression { params.ACCOUNT == 'prod' }
                }
            }
            steps {
                dir(params.ACCOUNT) {
                    sh '''
                    echo "Running terraform plan..."
                    terraform init -no-color
                    terraform plan -no-color
                    '''
                }
            }
        }
        stage('Terraform Apply') {
            when {
                allOf {
                    expression { params.TERRAFORM_ACTION == 'apply' }
                    expression { params.ACCOUNT == 'dev' }
                }
            }
            steps {
                dir('dev'){
                    sh '''
                    echo "Running terraform apply..."
                    terraform init -no-color
                    terraform apply -auto-approve -no-color
                    '''
                }
            }
        }
        stage('Terraform Destroy') {
             when {
                allOf {
                    expression { params.TERRAFORM_ACTION == 'destroy' }
                    expression { params.ACCOUNT == 'dev' }
                }
            }
            steps {
                dir('dev'){
                    sh '''
                    echo "Running terraform destroy..."
                    terraform init -no-color
                    terraform destroy -auto-approve -no-color
                    '''
                }
            }
        }
    }
}