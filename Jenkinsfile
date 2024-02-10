pipeline {
    agent any

    environment {
        // Define empty variable initially
        ACCOUNT_ID = ""
    }

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
                echo 'curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash'
                echo 'tfsec --version'
                echo "******SCANNING WITH TFSEC*******"
                echo 'tfsec -m HIGH -s --no-colour && tfsec -m CRITICAL -s --no-colour'
            }
        }
        stage('Setting AWS Credential') {
            steps {
                script { 
                    if (params.ACCOUNT == 'dev') {
                        env.ACCOUNT_ID = '123'
                    } else if (params.ACCOUNT == 'prod') {
                        env.ACCOUNT_ID = '789'
                    } else {
                        error("Oops!! Invalid environment selected.")
                    }
                }
                dir(params.ACCOUNT) {
                    sh 'account.sh ${env.ACCOUNT_ID} ${REGION}'
                }
                
            }
        }
        stage('Terraform Plan') {
            when {
                expression { params.TERRAFORM_ACTION == 'plan' }

                anyOf {
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
                expression { params.TERRAFORM_ACTION == 'apply' }

                anyOf {
                      expression { params.ACCOUNT == 'dev' }
                      expression { params.ACCOUNT == 'prod' }
                }
            }
            steps {
                dir(params.ACCOUNT){
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
                expression { params.TERRAFORM_ACTION == 'destroy' }

                anyOf {
                      expression { params.ACCOUNT == 'dev' }
                      expression { params.ACCOUNT == 'prod' }
                }
            }
            steps {
                dir(params.ACCOUNT){
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