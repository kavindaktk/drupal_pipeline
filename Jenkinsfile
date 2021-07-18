pipeline {  
    
    environment { registry = "http://localhost:5000"}  
    agent { dockerfile true }  
    
    stages {
    
        stage('Building image') {
      
            steps{
        
                script {
                    def appimage = docker.build("drupal:${env.BUILD_ID}")
                    //docker.build registry + "/drupal:$BUILD_NUMBER"
        
                }
      
            }
    
        }
  
    }

}
