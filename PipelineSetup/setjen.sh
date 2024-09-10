#!/bin/bash
# Working on the assumption that you have Helm installed.
set -e
echo "Adding Helm repository for Jenkins..."
helm repo add jenkins https://charts.jenkins.io
echo "Updating Helm repositories..."
helm repo update
echo "Creating Jenkins namespace..."
kubectl create ns jenkins
echo "Installing Jenkins via Helm..."
helm install jenkins jenkins/jenkins -n jenkins --set controller.service.type=LoadBalancer
echo "Waiting for Jenkins to be ready..."
sleep(60)
echo "Retrieving Jenkins admin password..."
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
echo "Retrieving Jenkins service details..."
kubectl get svc -n jenkins
echo "Installation complete! 
echo "Jenkins should now be accessible via the IP address listed above."
