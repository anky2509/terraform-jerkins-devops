pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = 'AKIA6ODU5KEL63VXQNOL'    // Your AWS Access Key ID
        AWS_SECRET_ACCESS_KEY = 'i+5Fc5eo3ThVFrBUV/8PF18GKxuhDt3zstsEE0dV'  // Your AWS Secret Access Key
    }

    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
                    dir("terraform") {
                        git branch: 'main', url: 'https://github.com/anky2509/terraform-jerkins-devops.git'
                    }
                }
            }
        }
        stage('Plan') {
            steps {
                sh 'pwd; cd terraform/; terraform init'
                sh "pwd; cd terraform/; terraform plan -out tfplan"
                sh 'pwd; cd terraform/; terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }
            steps {
                script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
        stage('Apply') {
            steps {
                sh "pwd; cd terraform/; terraform apply -input=false tfplan"
            }
        }
    }
}
