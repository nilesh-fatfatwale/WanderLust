@Library('Shared') _
pipeline {
  agent any


  parameters {
    string(name: 'FrontendImageTag', defaultValue: '', description: 'Setting docker image for latest push')
    string(name: 'BackendImageTag', defaultValue: '', description: 'Setting docker image for latest push')
  }

  stages {

    stage("Validate Parameters") {
      steps {
        script {
          if (params.FrontendImageTag == '' && params.BackendImageTag == '') {
            error("FrontendImageTag and BackendImageTag must be provided")
          }
        }
      }
    }

    stage("Workspace Cleanup") {
      steps {
        cleanWs()
      }
    }

    stage("Git Clone") {
      steps {
        script {
          code_checkout("https://github.com/nilesh-fatfatwale/WanderLust.git", "main")
        }
      }
    }

    stage("Scan") {
      steps {
        script {
          trivy_scan()
        }
      }
    }

    stage("Docker Build") {
      steps {
        script {
          docker_build("nileshfatfatwale", "WanderLustBackend", params.BackendImageTag)
          docker_build("nileshfatfatwale", "WanderLustFrontend", params.FrontendImageTag)
        }
      }
    }

    stage("Docker Push") {
      steps {
        script {
          dir('backend') {
            docker_push("nileshfatfatwale", "WanderLustBackend", params.BackendImageTag)
          }
          dir('frontend') {
            docker_push("nileshfatfatwale", "WanderLustFrontend", params.FrontendImageTag)
          }
        }
      }
    }
  }
}
