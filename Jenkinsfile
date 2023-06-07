def repo_url = 'https://github.com/sajidasan/hrl.git'
def repo_branch = 'main'
def build_file_name = 'helloworld'
def artifactory_target = 'c_repo-generic-local/froggy-files3/'
def email_to = 'saji.dasan010@gmail.com'

pipeline {
    agent any
    tools {
		maven '3.9.2'
		}
    stages {
        stage("Clone code from github"){
            steps {
                git branch: repo_branch, url: repo_url
            }
        }
        
        stage("Build C code"){
            steps {
			   sh "make"
            }
        }
        
        stage("Upload to artifactory") {
            steps {
                    rtUpload (
                    serverId: 'Artifactory',
                    spec: """{
                          "files": [
                            {
                              "pattern": "${build_file_name}",
                              "target": "${artifactory_target}"
                            }
                         ]
                    }"""
                )
            }
        }
    }
    post {
        always {
            cleanWs notFailBuild: true
        }
        success {
            emailext body: 'Job successfully built',
            subject: 'Artifactory build - success',
            to: email_to

        }
        failure {
            emailext body: 'Job failed to build',
            subject: 'Artifactory build - fail',
            to: email_to

        }
    }
}