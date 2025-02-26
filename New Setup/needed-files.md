inventory/hosts: Inventory file listing all hosts and groups.
roles/linux-prereq/tasks/*.yml: Tasks for installing prerequisites on Linux hosts.
roles/linux-airgap/tasks/*.yml: Tasks for setting up airgapped repositories on Linux hosts.
roles/proxmox-prereq/tasks/*.yml: Tasks for installing prerequisites on Proxmox hosts.
roles/proxmox-airgap/tasks/*.yml: Tasks for setting up airgapped repositories on Proxmox hosts.
roles/wyze/tasks/*.yml: Tasks specific to Wyze devices.
roles/tower/tasks/*.yml: Tasks specific to the Tower host.
roles/all-in-one/tasks/*.yml: Tasks specific to the All-In-One host.
roles/k3s-server/tasks/*.yml: Tasks for setting up K3s server nodes.
roles/k3s-agent/tasks/*.yml: Tasks for setting up K3s agent nodes.