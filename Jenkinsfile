pipeline {
    agent any

    environment {
        AWS_REGION   = 'us-east-2'
        AWS_CREDS    = 'codebuild-creds'
        PROJECT_NAME = 'devops'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Plan (CodeBuild)') {
            steps {
                echo "PLAN → CodeBuild"

                withAWS(credentials: AWS_CREDS, region: AWS_REGION) {
                    awsCodeBuild(
                        credentialsType: 'jenkins',      // 🔴 REQUIRED
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceControlType: 'project',
                        sourceVersion: 'main',
                        envVariables: '[{"name":"ACTION","value":"plan"}]'
                    )
                }
            }
        }

        stage('Approval') {
            steps {
                input message: "Review plan. Proceed?"
            }
        }

        stage('Terraform Apply (CodeBuild)') {
            steps {
                echo "APPLY → CodeBuild"

                withAWS(credentials: AWS_CREDS, region: AWS_REGION) {
                    awsCodeBuild(
                        credentialsType: 'jenkins',      // 🔴 REQUIRED
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceControlType: 'project',
                        sourceVersion: 'main',
                        envVariables: '[{"name":"ACTION","value":"apply"}]'
                    )
                }
            }
        }
    }

    post {
        success { echo "SUCCESS" }
        failure { echo "FAILURE" }
    }
}
