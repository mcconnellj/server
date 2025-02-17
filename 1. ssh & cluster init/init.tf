# Provisioner to install software and configure the environment on the local machine
resource "null_resource" "local_setup" {
  provisioner "local-exec" {
    command = <<-EOT
      # Update system
      sudo apt-get update -y
      sudo apt-get upgrade -y
      
      # Install Git, Minikube, Helm, and Visual Studio Code Server
      sudo apt-get install -y git
      curl -Lo minikube-linux-amd64 https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && sudo chmod +x minikube-linux-amd64 && sudo mv minikube-linux-amd64 /usr/local/bin/minikube
      curl https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz -o helm.tar.gz
      tar -zxvf helm.tar.gz
      sudo mv linux-amd64/helm /usr/local/bin/helm
      curl -fsSL https://code-server.dev/install.sh | sh  # Install Visual Studio Code Server
      
      # Start Minikube with persistent storage configuration
      minikube start --memory=4096 --cpus=2 --disk-size=50g
      
      # Clone private Git repository to the home directory (~)
      git clone https://github.com/dec.git ~/dec-repo
      
      # Set up Kubernetes CLI
      export KUBEVIRT_NAMESPACE=default
      
      # Add Helm repos and install agro-cd (creating namespace inline)
      helm repo add argo https://argoproj.github.io/argo-helm
      helm repo update
      helm install agro-cd argo/argo-cd --namespace argocd --create-namespace
      
      # Apply Kubernetes resources (secrets from the private repo)
      kubectl apply -f ~/dec-repo/environments/development/secrets.yaml
      
      # Apply app configurations from the repo (e.g., private repo, app-of-apps)
      kubectl apply -f ~/dec-repo/environments/development/private-repo-config.yaml  # Adjust as needed
      kubectl apply -f ~/dec-repo/environments/development/app-of-apps.yaml  # Adjust as needed
    EOT
  }
}
