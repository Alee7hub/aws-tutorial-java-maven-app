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

        // stage("deploy") {
        //     steps {
        //         script {
        //             echo "Deploying the application ..."
        //             withCredentials([usernamePassword(credentialsId: 'aws-jenkins-key', 
        //                                             usernameVariable: 'AWS_ACCESS_KEY_ID', 
        //                                             passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        //                 sh '''
        //                 aws ssm send-command \
        //                 --instance-ids i-08fb1bc876cd3897b \
        //                 --document-name "AWS-RunShellScript" \
        //                 --parameters 'commands=["docker run -p 3080:3080 -d alikakavand/demo-app:1.0"]' \
        //                 --region eu-central-1
        //                 '''
        //             }
        //         }
        //     }
        // }
        stage("deploy") {
            steps {
                script {
                    echo "Deploying the application ..."
                    def dockerCmd = "docker run -p 8080:8080 -d alikakavand/demo-app:1.0"
                    sshagent (['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@18.194.233.241 ${dockerCmd}"
                    }
                }
            }
        }               
    }
} 
