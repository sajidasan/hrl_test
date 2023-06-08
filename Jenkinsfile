def repo_url = 'https://github.com/sajidasan/c_code.git'
def repo_branch = 'main'
def email_to = 'saji.dasan01@gmail.com'
def files
def base

pipeline {
    agent any
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
                script {
                    files = findFiles(glob: '*.c') 
                    base = """${files[0].name}""".replace(".c","")
                    artifactory_target = """c_repo-generic-local/${base}/"""
                }
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