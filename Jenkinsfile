    // def userGit = "bibee"
    def userDocker = "babibe2211"
    // def repository = "https://github.com/PETW-Dapps/PETW-LDP"
    def repository = "https://github.com/pmbibe/jenkins-with-tomcat"
    def dockerRegistry = "https://registry.hub.docker.com"
    def branch = "master"
    def prj = "tomcat"
    def dockerBuildLabel = "builder"
    def nexusInstanceId = "nexus_jenkins"
    def nexusRepositoryId = "jenkins-test"
    def filePath = "webapp/target/webapp.war"
    def nexusBaseURL = "http://167.172.80.13:8082"
    def nexusRepository = "jenkins-test"
    def groupID = "com.mycompany.app"
    def artifactID = "tomcat-app"
    def localFile = "webapp.war"
    def extension = "war"
    def version = "1.4"

    node("jenkins-agent") {
            stage("Pull code from GitLab"){
                    // git branch: "${branch}", credentialsId: "${userGit}", url: "${repository}"
                    git branch: "${branch}", url: "${repository}"
            }
            
            stage("Search and Dowload"){
                withCredentials([usernamePassword(credentialsId: 'jenkins_nexus', passwordVariable: 'nexus_password', usernameVariable: 'nexus_username')]) {
                sh """
                    curl -o ${localFile} -u $nexus_username:$nexus_password -L -X GET '${nexusBaseURL}/service/rest/v1/search/assets/download?group=${groupID}&name=${artifactID}&version=${version}&maven.extension=${extension}'
                """
                }

            }

            stage ("Build image") {
                customImage = docker.build("${userDocker}/${prj}:${BUILD_ID}", "--no-cache --build-arg filePath=${localFile} .")
             
            }

            stage ("Push image") {
                withDockerRegistry([url: "", credentialsId: "${userDocker}"]) {
                customImage.push()   
                }
            stage ("Clear all") {
                env.user = userDocker
                env.project = prj
                sh '''
                    docker image rm ${user}/${project}:${BUILD_ID}
                '''
            }
            }            


    }


