pipeline {
    agent any

    environment {
        AWS_REGION      = 'us-east-1'
        CODEBUILD_CREDS = 'codebuild-creds'
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
                    echo "PLAN → CodeBuild"

                    awsCodeBuild(
                        credentialsType: 'keys',
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceControlType: 'project',     // REQUIRED
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
                script {
                    echo "APPLY → CodeBuild"

                    awsCodeBuild(
                        credentialsType: 'keys',
                        credentialsId: CODEBUILD_CREDS,
                        projectName: PROJECT_NAME,
                        region: AWS_REGION,
                        sourceControlType: 'project',     // REQUIRED
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
