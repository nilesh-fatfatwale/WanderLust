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
          dir('backend') {
          docker_build("nileshfatfatwale", "wanderlustbackend", params.BackendImageTag)
          }
           dir('frontend') {
           docker_build("nileshfatfatwale", "wanderlustfrontend", params.FrontendImageTag)
           }
        }
      }
    }

    stage("Docker Push") {
      steps {
        script {
            docker_push("nileshfatfatwale", "wanderlustbackend", params.BackendImageTag)
            docker_push("nileshfatfatwale", "wanderlustfrontend", params.FrontendImageTag)
        }
      }
    }
  }
}
