pipeline {
    agent any
    
    environment {
        // Docker Hub credentials
        DOCKER_CREDENTIALS_ID = 'psinadevapp'
        // Docker Hub repository
        DOCKER_REPO = 'psinadevapp/weather-microservice'
        // Kubernetes namespace
        K8S_NAMESPACE = 'jenkins'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                git 'https://github.com/psinadevapp/inadevcodereq.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    def imageName = "${DOCKER_REPO}:latest"
                    docker.build(imageName)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push Docker image to Docker Hub
                    def imageName = "${DOCKER_REPO}:latest"
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image(imageName).push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Set Kubernetes context
                    sh "kubectl config use-context ${K8S_CONTEXT}"
                    
                    // Create Kubernetes deployment YAML file
                    def deploymentYAML = '''
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inadevcodereq
  namespace: ${K8S_NAMESPACE}
spec:
  replicas: 2
  selector:
    matchLabels:
      app: inadevcodereq
  template:
    metadata:
      labels:
        app: inadevcodereq
    spec:
      containers:
      - name: inadevcodereq
        image: ${DOCKER_REPO}:latest
        ports:
        - containerPort: 5000
  '''
                    
                    writeFile file: 'deployment.yaml', text: deploymentYAML

                    // Apply deployment to Kubernetes
                    sh "kubectl apply -f deployment.yaml"
                    
                    // Create Kubernetes service YAML file
                    def serviceYAML = '''
apiVersion: v1
kind: Service
metadata:
  name: inadevcodereq
  namespace: ${K8S_NAMESPACE}
spec:
  type: LoadBalancer
  selector:
    app: inadevcodereq
  ports:
  - protocol: TCP
    port: 80
    targetPort: 5000
  '''

                    writeFile file: 'service.yaml', text: serviceYAML

                    // Apply service to Kubernetes
                    sh "kubectl apply -f service.yaml"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
