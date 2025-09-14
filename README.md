# tzlab - OCI 3-Node DevOps Lab  

This repository documents my personal **tzlab** built on **Oracle Cloud Infrastructure (OCI)**.  
The environment is designed for learning, automation, and real-world portfolio projects.  

![tzlab](https://github.com/user-attachments/assets/b529a4b2-5364-4213-a8c2-bb652ff57577)


## Architecture  
- **3 Nodes (OCI Ampere instances)**  
- **Terraform** – infrastructure provisioning (VCN, subnets, compute, networking)  
- **Ansible** – server configuration & automation  
- **MicroCeph** – distributed storage across nodes  
- **Docker Swarm** – container orchestration for services and stacks  
- **Traefik** – reverse proxy and TLS management ([p02traefik.tomaszelenka.cz](https://p02traefik.tomaszelenka.cz))  
- **Portainer** – container management GUI  
- **Monitoring** – Grafana, Prometheus, Loki  ([p03grafana.tomaszelenka.cz](https://p03grafana.tomaszelenka.cz))  
<img width="1703" height="867" alt="image" src="https://github.com/user-attachments/assets/a5408cdb-667b-443e-ab86-b17393713dbb" />


## Goals  
- Demonstrate infrastructure as code (IaC) with Terraform and Ansible  
- Practice cluster deployment, storage replication, and high availability concepts  
- Run monitoring, reverse proxy, and management stacks in a realistic multi-node setup  

## Next Steps  
- Extend with CI/CD pipelines (GitHub Actions, Azure DevOps etc.)  
- Add Kubernetes (k3s / RKE2) as an alternative to Docker Swarm  
