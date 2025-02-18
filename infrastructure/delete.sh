#!/bin/bash
minikube stop
minikube delete
minikube start
echo "Minikube has been restarted successfully."
