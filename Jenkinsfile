pipeline {
    agent any

    environment {
        AWS_REGION      = 'us-east-1'
        CODEBUILD_CREDS = 'codebuild-creds'    // Your new CodeBuild credential ID
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

                    awsCodeBuild(
                        credentialsType: 'keys',
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceControlType: 'project',   // REQUIRED FIX
                        sourceVersion: "main",
                        envVariables: '[{"name":"ACTION","value":"plan"}]'
                    )
                }
            }
        }

        stage('Approval') {
            steps {
                input message: "Review plan. Proceed with apply?"
            }
        }

        stage('Terraform Apply (CodeBuild)') {
            steps {
                script {
                    echo "Triggering Terraform APPLY via CodeBuild"

                    awsCodeBuild(
                        credentialsType: 'keys',
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceControlType: 'project',   // REQUIRED FIX
                        sourceVersion: "main",
                        envVariables: '[{"name":"ACTION","value":"apply"}]'
                    )
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
