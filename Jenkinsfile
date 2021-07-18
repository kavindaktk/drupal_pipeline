pipeline {
    agent any 
    environment {       registry = "localhost:5000" }  
  
    
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
            script { 
                //def image = "--extra-vars \\"image_id=' + ${env.BUILD_ID} + '\\"
                def image = "--extra-vars image_id=${env.BUILD_ID}"
                //println "TEST ${image}"
                ansiblePlaybook  extras: "${image} -b",installation: 'ansible2', playbook: 'k8_deploy.yaml'
            }
                }      
        }
        
      
      
    }
}


