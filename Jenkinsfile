@library(['piper-lib']) _
          pipeline{
            agent any
            options {
              disableConcurrentBuilds()
            }
            stages {
              stage('prepare') {
                when { anyOf { branch 'master' } }
                steps { 
                  checkout scm
                  setupCommonPipelineEnvironment script:this 
                }
              }
              stage('Deploy') { 
                when { anyOf { branch 'master' } } 
                steps {
                 echo "Deploying..."
                
              }
            }
          }
          }
