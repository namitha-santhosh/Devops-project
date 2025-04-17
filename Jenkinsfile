pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'
        jdk 'JDK17'
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/namitha-santhosh/Devops-project.git'
            }
        }
        
        stage('Build') {
            steps {
                    sh 'mvn clean install'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                    withSonarQubeEnv('Sonar-server') {
                        sh 'mvn sonar:sonar'
                    }
            }
        }
        stage('Upload to Nexus') {
            steps {
                    sh 'mvn deploy'
                }
        }
        stage('Image Build') {
            steps {
                script {
                    sh "docker build --no-cache -t namitha612/jenkins-app:latest ."
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-pat-nami', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push namitha612/jenkins-app:latest
                    """
                    }
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                script {
                    withAWS(credentials: 'aws-credentials', region: 'ap-south-1') {
                        withKubeConfig([
                            credentialsId: 'kubernetescredentials',
                            serverUrl: 'https://d2dd3f58d2418976a35b32a39edafdd7.gr7.ap-south-1.eks.amazonaws.com'
                        ]) {
                            sh '''
                                
        
                                echo "Applying Kubernetes YAML files..."
                                kubectl --kubeconfig=$KUBECONFIG apply -f K8s/postgres-deployment.yaml
                                kubectl --kubeconfig=$KUBECONFIG apply -f K8s/springboot-deployment.yaml
        
                                echo "Waiting for pods to be ready..."
                                kubectl --kubeconfig=$KUBECONFIG get pods -o wide
        
                                echo "Services:"
                                kubectl --kubeconfig=$KUBECONFIG get svc
                            '''
                        }
                    }
                }
            }
        }
   }
}
