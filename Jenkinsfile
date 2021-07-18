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
                // This step should not normally be used in your script. Consult the inline help for details.
                //def appimage = docker.build("drupal:${env.BUILD_ID}")
                withDockerRegistry(toolName: 'docker2', url: 'http://localhost:5000') {
                    //appimage.push()   
                }
                }

                
                
              //script { 
              //    def appimage = docker.build("drupal:${env.BUILD_ID}")
               //       docker.withRegistry( 'http://localhost:5000' ){                       
              //        appimage.push()                       
               //       appimage.push('latest')                  
               //       }              
                //    }
            }
        }
        
        
      stage ('Deploy')  {           
        steps {     
             ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible2', inventory: 'prod.inv', playbook: 'k8_deploy.yaml'
                }      
        }
        
      
      
    }
}
