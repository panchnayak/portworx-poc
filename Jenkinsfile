pipeline {
  agent any
  stages {
    stage('Deploy Shared V4 Demo') {
      parallel {
        stage('Deploy Shared V4 Demo') {
          steps {
            sh 'echo \'Deploy Shared V4\''
          }
        }

        stage('Delete Shared V4 Demo Env') {
          steps {
            sh 'echo \'Delete Shared V4 Demo Env\''
          }
        }

      }
    }

    stage('Create Shared V4 SC') {
      parallel {
        stage('Create Shared V4 SC') {
          steps {
            sh 'echo \'Create Shared SC\''
          }
        }

        stage('Delete Second Webserver') {
          steps {
            sh 'echo \'Delete Second Webserver\''
          }
        }

      }
    }

    stage('Create Shared PVC') {
      parallel {
        stage('Create Shared PVC') {
          steps {
            sh 'echo \'Create Shared V4 Volume\''
          }
        }

        stage('Delete First Webserver') {
          steps {
            sh 'echo \'Delete First Webserver\''
          }
        }

      }
    }

    stage('Create first Webserver') {
      parallel {
        stage('Create first Webserver') {
          steps {
            sh 'echo \'Create First Webserver\''
          }
        }

        stage('Delete Shared PVC') {
          steps {
            sh 'echo \'Delete Shared PVC\''
          }
        }

      }
    }

    stage('Create Second Webserver') {
      parallel {
        stage('Create Second Webserver') {
          steps {
            sh 'echo \'Create Second Webserver\''
          }
        }

        stage('Delete Shared SC') {
          steps {
            sh 'echo \'Delete Shred SC\''
          }
        }

      }
    }

  }
  environment {
    AWS_CREDENTIAL = 'pnayak-aws'
  }
}