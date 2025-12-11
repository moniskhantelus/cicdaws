pipeline {
    agent any

    environment {
        AWS_REGION      = 'us-east-1'
        CODEBUILD_CREDS = 'e1aa3d2f-6847-44cb-96cd-c2e335131379'
        PROJECT_NAME    = 'devops'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Plan (CodeBuild)') {
            steps {
                script {
                    echo "Triggering Terraform PLAN via CodeBuild"

                    def result = awsCodeBuild(
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceVersion: "main",
                        envVariables: [
                            [key: 'ACTION', value: 'plan']
                        ],
                        waitForCompletion: true
                    )

                    echo "PLAN build result: ${result.buildStatus}"
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    input message: "Review Terraform plan. Proceed with apply?"
                }
            }
        }

        stage('Terraform Apply (CodeBuild)') {
            steps {
                script {
                    echo "Triggering Terraform APPLY via CodeBuild"

                    def result = awsCodeBuild(
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceVersion: "main",
                        envVariables: [
                            [key: 'ACTION', value: 'apply']
                        ],
                        waitForCompletion: true
                    )

                    echo "APPLY build result: ${result.buildStatus}"
                }
            }
        }
    }

    post {
        success {
            echo "Terraform deployment SUCCESSFUL!"
        }
        failure {
            echo "Terraform deployment FAILED."
        }
    }
}
