def repo_url = 'https://github.com/sajidasan/hrl.git'
def repo_branch = 'main'
def artifactory_repo_name = 'c_repo-generic-local'
def email_to = 'saji.dasan01@gmail.com'
def date = String.format('%tF.%<tH:%<tM', java.time.LocalDateTime.now())
def files
def base

pipeline {
    agent any
    stages {
        stage("Clone Code from GitHub"){
            steps {
                git branch: repo_branch, url: repo_url
            }
        }
        
        stage("Build C Code"){
            steps {
                  sh "make"
            }
        }
        stage("Parse Filename") {
            steps {
                script {
                    files = findFiles(glob: '*.c') 
                    base = files[0].name.replace(".c","")
                    artifactory_target = """${artifactory_repo_name}/${base}-${date}/"""
                }
            }
        }
        stage("Upload to Artifactory") {
            steps {
                    rtUpload (
                    serverId: 'Artifactory',
                    spec: """{
                          "files": [
                            {
                              "pattern": "${base}",
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
        //success {
        //    emailext body: 'Job successfully built',
        //    subject: 'Artifactory build - success',
        //    to: email_to
        //}
        failure {
            emailext body: 'Job failed to build',
            subject: 'Artifactory build - fail',
            to: email_to

        }
    }
}