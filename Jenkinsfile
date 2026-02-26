#!/usr/bin.env groovy

pipeline {   
    agent any
    stages {
        stage("test") {
            steps {
                script {
                    echo "Testing the application..."

                }
            }
        }
        stage("build") {
            steps {
                script {
                    echo "Building the application..."
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    echo "Deploying the application ..."
                    withCredentials([usernamePassword(credentialsId: 'aws-jenkins-key', 
                                                    usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                                    passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        aws ssm send-command \
                        --instance-ids i-08fb1bc876cd3897b \
                        --document-name "AWS-RunShellScript" \
                        --parameters 'commands=["docker run -p 3080:3080 -d alikakavand/demo-app:1.0"]' \
                        --region eu-central-1
                        '''
                    }
                }
            }
        }               
    }
} 
