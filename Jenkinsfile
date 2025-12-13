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
                    credentialsType: 'jenkins',          // ✅ FIX
                    credentialsId: 'codebuild-creds',    // ✅ FIX
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
                    credentialsType: 'jenkins',          // ✅ FIX
                    credentialsId: 'codebuild-creds',    // ✅ FIX
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
