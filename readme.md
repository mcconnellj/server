==== Create Google Cloud Compute Engine E2 Micro ====

gcloud compute instances create argocd-control-plane --project=always-free-project-436620 --zone=us-central1-a --machine-type=e2-micro --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --metadata=enable-osconfig=TRUE --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=8559688915-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append --tags=argocd-server,http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=argocd-control-plane,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250212,mode=rw,size=30,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ops-agent-policy=v2-x86-template-1-4-0,goog-ec-src=vm_add-gcloud --reservation-affinity=any && printf 'agentsRule:\n  packageState: installed\n  version: latest\ninstanceFilter:\n  inclusionLabels:\n  - labels:\n      goog-ops-agent-policy: v2-x86-template-1-4-0\n' > config.yaml && gcloud compute instances ops-agents policies create goog-ops-agent-v2-x86-template-1-4-0-us-central1-a --project=always-free-project-436620 --zone=us-central1-a --file=config.yaml


==== Linux Install Helm ====
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm


==== Linux Install Minikube ====
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64


==== Linux Install Git & Pull Repo ====
sudo apt-get install git
sudo git clone https://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@github.com/mcconnellj/server.git


==== Access Repo & Install Argo CD Using Helm ====




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


