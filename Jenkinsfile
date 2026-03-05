#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/Alee7hub/jenkins-shared-library.git',
    credentialsId: 'github-pat'
    ]
)

pipeline {
    agent any
    tools {
        maven 'maven-3.9'
    }
    environment {
        IMAGE_NAME = "alikakavand/demo-app:jma-2.0"
    }
    stages {
        // stage('increment version') {
        //     steps {
        //         script {
        //             echo 'incrementing app version...'
        //             sh 'mvn build-helper:parse-version versions:set \
        //                 -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
        //                 versions:commit'
        //             def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
        //             def version = matcher[0][1]
        //             env.IMAGE_NAME = "alikakavand/demo-app:$version-$BUILD_NUMBER"
        //         }
        //     }
        // }
        stage('build app') {
            steps {
                echo 'building application jar...'
                buildJar()
            }
        }
        stage('build image') {
            steps {
                script {
                    echo 'building the docker image...'
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        } 
        stage("deploy") {
            steps {
                script {
                    echo 'deploying docker image to EC2...'

                    def shellCmd = "bash ./server-cmds.sh ${env.IMAGE_NAME}"
                    
                    sshagent(['ec2-server-key']) {
                        sh 'scp server-cmds.sh ec2-user@18.194.233.241:/home/ec2-user'
                        sh 'scp docker-compose.yaml ec2-user@18.194.233.241:/home/ec2-user'
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@18.194.233.241 '${shellCmd}'"
                    }
                }
            }
        }
        // stage('commit version update'){
        //     steps {
        //         script {
        //             withCredentials([usernamePassword(credentialsId: 'github-pat', passwordVariable: 'PASS', usernameVariable: 'USER')]){
        //                 sh 'git config user.name "Jenkins CI"'
        //                 sh 'git config user.email "jenkins@example.com"'
        //                 sh 'git remote set-url origin https://$USER:$PASS@github.com/Alee7hub/java-maven-app.git'
        //                 sh 'git clean -fd target/ || true'
        //                 sh 'git rebase --abort || rm -fr .git/rebase-merge || true'
        //                 sh 'git add pom.xml'
        //                 sh 'git diff --cached --quiet || git commit -m "ci: version bump"'
        //                 sh 'git checkout -- .'
        //                 sh 'git pull --rebase origin jenkins-jobs'
        //                 sh 'git push origin HEAD:jenkins-jobs'
        //             }
        //         }
        //     }
        // }
    }
}
