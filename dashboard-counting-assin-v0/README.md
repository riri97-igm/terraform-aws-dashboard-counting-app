
# 🚀 Terraform AWS Dashboard-Counting App

This project provisions a simple microservices architecture on AWS using Terraform.

It deploys:
**Dashboard service** (public-facing)
**Counting service** (private backend)

The Dashboard communicates with the Counting service via private network.

---

## 🧱 Architecture Overview

            🌐 Internet
                 │
                 ▼
        ┌──────────────────┐
        │  Public Subnet   │
        │                  │
        │  Dashboard VM    │
        │  Port: 9002      │
        └────────┬─────────┘
                 │ (HTTP)
                 ▼
        ┌──────────────────┐
        │  Private Subnet  │
        │                  │
        │  Counting VM     │
        │  Port: 9003      │
        └──────────────────┘


## ⚙️ Tech Stack

- Terraform
- AWS EC2
- AWS VPC (public + private subnet)
- Security Groups
- Systemd services
- Bash (user_data scripts)

---

## 📁 Project Structure

.
├── data.tf

├── instance.tf

├── keypair.tf

├── outputs.tf

├── variables.tf

├── versions.tf

├── vpc.tf

├── terraform.tfvars

├── scripts/

│   ├── dashboard-service.sh

│   └── counting-service.sh



## 🔑 Key Features

- Uses **dynamic Ubuntu AMI** (no hardcoding)
- Uses **existing AWS key pair** (no local `.pub` needed)
- Dashboard connects to counting via **private IP**
- Infrastructure is modular and reusable using **prefix**
- Services run automatically using **systemd**

---

## 🚀 How to Run

### 1. Prerequisites

- Terraform installed
- AWS CLI configured
- Existing EC2 key pair in AWS

---

### 2. Configure variables

Edit `terraform.tfvars`:

```hcl
prefix         = "dashboard-counting"
region         = "ap-southeast-1"
instance_type  = "t3.micro"
key_name       = "your-keypair-name"
my_ip_cidr     = "YOUR_IP/32"

---

### 3. Initialize Terraform

```bash
terraform init
```

---

### 4. Plan

```bash
terraform plan
```

---

### 5. Apply

```bash
terraform apply
```

---

### 6. Access Application

After apply:

```bash
terraform output dashboard_url
```

Open in browser:

```
http://<public_ip>:9002
```

---

## 🔐 Security Design

* Dashboard:

  * Public access (port 9002)
  * SSH restricted to your IP

* Counting:

  * Private subnet only
  * Only accessible from Dashboard (SG-to-SG rule)

---

## ⚡ Services

### Dashboard Service

* Runs on port **9002**
* Calls Counting service via private IP

### Counting Service

* Runs on port **9003**
* Internal backend service

---

## 🛠 Scripts

* Dashboard setup script


* Counting setup script


Both scripts:

* install dependencies
* download binaries
* configure systemd
* auto-start services

---

## 📤 Outputs

```bash
terraform output
```

Example:

```
dashboard_public_ip = "18.x.x.x"
dashboard_url       = "http://18.x.x.x:9002"
counting_private_ip = "172.16.x.x"
```

---

## 🧠 Summary

This project demonstrates:

* Infrastructure as Code (Terraform)
* Secure AWS architecture (public + private subnet)
* Service-to-service communication
* Automation with user_data
* Clean and reusable Terraform design

---

## 📌 Future Improvements

* Add Load Balancer (ALB)
* Add Auto Scaling Group
* Use Terraform modules
* Add CI/CD pipeline

```

---
