pipeline {
    agent any 
    environment {       registry = "localhost:5000"}  
  
    
    stages {
        

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
          agent any 
        steps {     
             ansiblePlaybook disableHostKeyChecking: true, extras: '--extra-vars \\"image_id=${env.BUILD_ID}\\',installation: 'ansible2', inventory: 'prod.inv', playbook: 'k8_deploy.yaml'
                }      
        }
        
      
      
    }
}


