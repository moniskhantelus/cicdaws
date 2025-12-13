pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Plan (CodeBuild)') {
            steps {
                echo "PLAN → CodeBuild"

                awsCodeBuild(
                    credentialsType: 'keys',              // 🔴 REQUIRED
                    credentialsId: 'codebuild-creds',     // 🔴 REQUIRED
                    projectName: 'devops',
                    region: 'us-east-2',
                    sourceControlType: 'project',
                    sourceVersion: 'main',
                    envVariables: '[{"name":"ACTION","value":"plan"}]'
                )
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

                awsCodeBuild(
                    credentialsType: 'keys',
                    credentialsId: 'codebuild-creds',
                    projectName: 'devops',
                    region: 'us-east-2',
                    sourceControlType: 'project',
                    sourceVersion: 'main',
                    envVariables: '[{"name":"ACTION","value":"apply"}]'
                )
            }
        }
    }
}
