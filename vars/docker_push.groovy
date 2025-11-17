def call(String DockerHubUser , String ProjectName ,String ImageTag ){
withCredentials([usernamePassword(credentialsId: 'DockderHub',
usernameVariable: 'dockerHubUser',
passwordVariable: 'dockerHubPass' )]) {
sh 'docker login -u ${dockerHubUser} -p ${dockerHubPass}'
}
sh "docker push ${DockerHubUser}/${ProjectName}:${ImageTag}"
}
