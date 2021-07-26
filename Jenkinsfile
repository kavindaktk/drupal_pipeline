pipeline {
    agent any 
    environment {       registry = "625650193469.dkr.ecr.us-east-1.amazonaws.com" }  
  
    
    stages {
        
       stage('Clone Source Repo') {
           steps { 
             echo 'Make the output directory'
             sh 'mkdir -p build'
               dir('build') {
                  git branch: "master",  url: "https://github.com/kavindaktk/drupal_web.git"
              } 
           }
       }
        stage('Auth') {
           steps { 
             echo 'authering'
             sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin https://625650193469.dkr.ecr.us-east-1.amazonaws.com'
           }
       }
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
                def image = "--extra-vars image_id=${env.BUILD_ID}"
                //println "TEST ${image}"
                ansiblePlaybook  extras: "${image} -vvvv",installation: 'ansible2', playbook: 'k8_deploy.yaml'
            }
                }      
        }
        
      
      
    }
}


