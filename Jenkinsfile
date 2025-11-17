pipeline {
  agent any;

  parameters{
  string(name: 'FrontendImageTag', defaultValue: '', description: 'Setting docker image for latest push')
  string(name: 'BackendImageTag', defaultValue: '', description: 'Setting docker image for latest push')
  }

  stage("validate parameters") {
    steps {
      script {
        if (parms.FrontendImageTag == '' && parms.BackendImageTag == '') {
          error("FrontendImageTag and BackendImageTag must be provided")
        }
      }
    }
  }

  stage("Workspace Cleanup") {
    steps {
      script {
        cleanWs()
      }
    }
  }
  stage("Git Clone") {
    steps {
      script {
        code_checkout("https://github.com/nilesh-fatfatwale/WanderLust.git","main")
      }
    }
  }
  stages {
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
          docker_build("nileshfatfatwale", "WanderLustBackend",${parms.BackendImageTag})
          docker_build("nileshfatfatwale", "WanderLustFrontend",${parms.FrontendImageTag})
        }
      }

      stage("Docker: docker_push") {
        steps {
          script {
            dir('backend'){
              docker_push("nileshfatfatwale", "WanderLustBackend",${parms.BackendImageTag})}
            dir('frontend') {
              docker_push("nileshfatfatwale", "WanderLustFrontend",${parms.FrontendImageTag})
            }
          }
        }
      }
    }
  }
