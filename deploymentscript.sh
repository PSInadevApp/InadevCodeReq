#!/bin/bash
# Setting things up with Terraform and Helm
set -e

echo "Setting up Kubernetes Cluster and Jenkins..."
echo "Setting up Cluster..."
    cd terraform
    terraform init
    terraform apply -auto-approve
    cd ..
echo "Kubernetes Cluster created."

echo "Installing Jenkins..."
    helm repo add jenkins https://charts.jenkins.io
    helm repo update
    kubectl create namespace jenkins
    helm install jenkins jenkins/jenkins --namespace jenkins

    # Wait for Jenkins to be ready
    sleep 60
echo "Jenkins installed."
kubectl get svc -n jenkins



# Step 3: Create Jenkins pipeline for the microservice
create_pipeline() {
    echo "Creating Jenkins pipeline..."
    echo "Setting up the Jenkins job to monitor the GitHub repository..."
    # Remember to fill this!!!
    echo "Pipeline creation assumed."
}

# Step 4: Trigger Jenkins pipeline
trigger_pipeline() {
    echo "Triggering Jenkins pipeline..."
    # Use the Jenkins API to trigger the pipeline
    JENKINS_URL="http://<JENKINS_SERVER_IP>:8080"
    JOB_NAME="InadevCodeReq"
    USER=""
    TOKEN=""
    curl -X POST "$JENKINS_URL/job/$JOB_NAME/build" --user "$USER:$TOKEN"
    echo "Pipeline triggered."
}

# Main function to orchestrate the entire process

    create_pipeline
    trigger_pipeline
