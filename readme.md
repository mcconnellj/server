Prerequisites:
- Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
- Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

- Git
- Terraform


-argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm install my-argo-cd argo/argo-cd --version 7.8.3
https://artifacthub.io/packages/helm/argo/argo-cd


Private Repository Details:
- url: https://github.com/mcconnellj/server
- password: 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
- username: josh.v.mcconnell@gmail.com

Commands:

git pull
cd ./infrastructure
terraform init
terraform apply -auto-approve
kubectl port-forward svc/argocd-server -n argocd 8080:443

After you are done that use these credentials to clone the private git repo in to the ~/ directory. stringData:


