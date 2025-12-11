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
                    def buildResult = codeBuild(
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        envVars: [
                            [key: 'ACTION', value: 'plan']
                        ],
                        waitForCompletion: true
                    )
                    echo "PLAN build status: ${buildResult.buildStatus}"
                    if (buildResult.buildStatus != 'SUCCEEDED') {
                        error("Terraform plan failed in CodeBuild!")
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    input message: "Review plan.txt in CodeBuild artifacts. Proceed to APPLY?"
                }
            }
        }

        stage('Terraform Apply (CodeBuild)') {
            steps {
                script {
                    echo "Triggering Terraform APPLY via CodeBuild"
                    def buildResult = codeBuild(
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        envVars: [
                            [key: 'ACTION', value: 'apply']
                        ],
                        waitForCompletion: true
                    )
                    echo "APPLY build status: ${buildResult.buildStatus}"
                    if (buildResult.buildStatus != 'SUCCEEDED') {
                        error("Terraform apply failed in CodeBuild!")
                    }
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
