pipeline {
    agent {
        //docker { image 'localhost:5000/drupal' }
        dockerfile true
    }
    environment {       registry = "localhost:5000"}  
  
  
    stages {
        stage('Test') {
            steps {
                sh 'php --version'
            }
        }
        
      
       stage('Publish') {
            steps {
              script { 
                  def appimage = docker.build("drupal:${env.BUILD_ID}")
                      docker.withRegistry( 'http://localhost:5000' ){                       
                      appimage.push()                       
                      appimage.push('latest')                  
                      }              
                    }
            }
        }
        
        
      stage ('Deploy')  {           
        steps {               
                 script{ 
                    def image_id = registry + ":$BUILD_NUMBER"
                    sh "ansible-playbook  playbook.yml --extra-vars \"image_id=${image_id}\""
                    }          
                }      
        }
        
      
      
    }
}
