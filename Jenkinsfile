pipeline {
    agent any 
    environment {       registry = "https://625650193469.dkr.ecr.us-east-1.amazonaws.com" }  
  
    
    stages {
        

      stage('Publish') {
            
           steps {
   
              script { 
                  def appimage = docker.build(registry + "/drupal:${env.BUILD_ID}")
                       docker.withRegistry( 'https://625650193469.dkr.ecr.us-east-1.amazonaws.com' ){                       
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
                ansiblePlaybook  extras: "${image} -vvvv",installation: 'ansible2', playbook: 'k8_deploy.yaml'
            }
                }      
        }
        
      
      
    }
}


