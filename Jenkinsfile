pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    triggers {
        pollSCM('* * * * *') // Poll every 1 minute
    }
    environment {
        BUILD_USER = bat(script: "echo %USERNAME%", returnStdout: true).trim().replaceAll('(?s)^.*?\r?\n', '')
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/himanshu110796/JenkinsDocker'
                script {
                    // Get latest commit details
                    env.GIT_AUTHOR = powershell(script: '(git log -1 --pretty=format:"%an").Trim()', returnStdout: true).trim()
                    env.GIT_COMMIT_MESSAGE = powershell(script: '(git log -1 --pretty=format:"%s").Trim()', returnStdout: true).trim()

                    echo "Latest Commit Author: ${env.GIT_AUTHOR}"
                    echo "Commit Message: ${env.GIT_COMMIT_MESSAGE}"
                }
            }
        }
        stage('Build with Maven') {
            steps {
                bat 'mvn clean package'
                bat 'for /F "delims=" %%A in (\'dir /B target\\*.jar\') do rename target\\%%A myapp.jar'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "myapp:${env.BUILD_ID}"
                    bat "docker build -t ${imageName} ."
                    echo "Docker Image Built: ${imageName}"
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    bat "docker stop myapp_container || exit 0"
                    bat "docker rm myapp_container || exit 0"
                    bat "docker run -d -p 8085:8085 --name myapp_container myapp:${env.BUILD_ID}"
                    echo "Application is running on http://localhost:8085"
                }
            }
        }
    }
    post {
        success {
            echo "Build Successful! 🎉"
            echo "The build was successful, and everything worked as expected."
        }
        failure {
            echo "Build Failed. ❌"
            echo "Something went wrong during the build process. Please check the logs for more details."
        }
    }
}