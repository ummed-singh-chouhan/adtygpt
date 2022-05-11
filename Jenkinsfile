@library(['piper-lib']) _
          pipeline{
            agent any
            options {
              disableConcurrentBuilds()
            }
            stages {
              stage('prepare') {
                when { anyof { branch 'main' } }
                steps { 
                  checkout scm
                  setupCommonPipelineEnvironment script:this 
                }
              }
              stage('Deploy') { 
                when { anyOf { branch 'main' } } 
                steps {
                  gctsDeploy(
                            Script : this 
                )
              }
            }
          }
          }
