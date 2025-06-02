pipeline{
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
         AWS_ACCESS_KEY_ID = credentials('aws_cred')
         AWS_SECRET_ACCESS_KEY = credentials('aws_cred')
         AWS_REGION = 'ap-south-1'
         ECR_PUBLIC_REGISTRY = 'public.ecr.aws/n0y2x5a0'
         ECR_REPOSITORY_URL = "${ECR_PUBLIC_REGISTRY}/demo-automation"
         IMAGE_TAG = 'latest'
     }
    stages{
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git') {
            steps {
                script{
                    git branch: 'main',
                    credentialsId : 'git_creential',
                    url: 'https://github.com/pawanhb/terraform-course.git'
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                script{
                    dir('tf-project'){
                        sh 'PATH=$PATH:/usr/local/bin/terraform_1.11.2_darwin_arm64/'
                        sh 'echo $PATH'
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formatting Terraform Code'){
            steps{
                script{
                    dir('tf-project'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('tf-project'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the Infra using Terraform'){
            steps{
                script{
                    dir('tf-project'){
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage('Creating EC2 instance'){
            steps{
                script{
                    dir('tf-project') {
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
    }
}
