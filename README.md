# tzlab - OCI 3-Node DevOps Lab  

This repository documents my personal **tzlab** built on **Oracle Cloud Infrastructure (OCI)**.  
The environment is designed for learning, automation, and real-world portfolio projects.  

## Architecture  
- **3 Nodes (OCI Ampere A1 instances)**  
- **Terraform** – infrastructure provisioning (VCN, subnets, compute, networking)  
- **Ansible** – server configuration & automation  
- **MicroCeph** – distributed storage across nodes  
- **Docker Swarm** – container orchestration for services and stacks  
- **Traefik** – reverse proxy and SSL management ([p02traefik.tomaszelenka.cz](https://p02traefik.tomaszelenka.cz))  
- **Portainer** – container management GUI  
- **Monitoring** – Grafana, Prometheus, Loki  

## Goals  
- Demonstrate infrastructure as code (IaC) with Terraform and Ansible  
- Practice cluster deployment, storage replication, and high availability concepts  
- Run monitoring, reverse proxy, and management stacks in a realistic multi-node setup  

## Next Steps  
- Extend with CI/CD pipelines (GitHub Actions, Azure DevOps etc.)  
- Add Kubernetes (k3s / RKE2) as an alternative to Swarm  
