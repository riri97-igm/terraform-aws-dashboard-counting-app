
# 🚀 Terraform AWS Dashboard-Counting App (Manual Provisioning)

This project provisions a secure AWS 2-tier architecture using Terraform with **manual resource definition (no external modules)**.

It deploys:
**public Dashboard service**
**private Counting backend service**

The Dashboard communicates with the Counting service via private network inside a VPC.

---

## 🧱 Architecture Overview


            🌐 Internet
                 │
                 ▼
        ┌──────────────────────┐
        │   Public Subnet      │
        │                      │
        │  EC2: Dashboard      │
        │  Port: 9002          │
        └──────────┬───────────┘
                   │ HTTP
                   ▼
        ┌──────────────────────┐
        │   Private Subnet     │
        │                      │
        │  EC2: Counting       │
        │  Port: 9003          │
        └──────────────────────┘

---

## ⚙️ Tech Stack

- Terraform
- AWS EC2
- AWS VPC (Manual configuration)
- Internet Gateway (IGW)
- NAT Gateway
- Route Tables
- Security Groups
- Bash (user_data scripts)
- Systemd services

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

├── scripts/

│   ├── dashboard-service.sh

│   └── counting-service.sh


---

## 🛠 Provisioning Approach (Manual)

This project manually defines all AWS resources:

- VPC
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Route tables
- Security groups
- EC2 instances

No Terraform modules are used.

---

## 🔑 Key Features

- Fully manual AWS infrastructure setup
- Strong AWS networking design (public + private subnet)
- Secure service-to-service communication using private IP
- Automated EC2 setup using `user_data`
- Services managed with systemd
- Clean Terraform structure

---

## 📋 Prerequisites

- Terraform installed
- AWS CLI configured
- AWS credentials (profile)

---

## ⚙️ Configuration

This project uses Terraform variables defined in `variables.tf`.

You can provide values in these ways:

- Default values in `variables.tf`
- CLI input during apply
- Using `-var` flag

Example:

```bash
terraform apply -var="prefix=dashboard-counting"
````

---

## 🚀 How to Run

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

If variables are required:

```bash
terraform apply -var="prefix=dashboard-counting"
```

---

## 🌐 Access Application

```bash
terraform output dashboard_url
```

Open:

```
http://<public_ip>:9002
```

---

## 🔐 Security Design

### Dashboard (Public)

* Accessible from internet (port 9002)
* SSH restricted to your IP

### Counting (Private)

* No public IP
* Only accessible from Dashboard via Security Group

---

## ⚡ Services

### Dashboard Service

* Runs on port **9002**
* Calls Counting service using private IP

### Counting Service

* Runs on port **9003**
* Internal backend service

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

## 🛠 Setup Scripts

### Dashboard Script

* Installs dependencies
* Downloads dashboard service
* Configures systemd
* Connects to counting service via private IP

### Counting Script

* Installs dependencies
* Downloads counting service
* Configures systemd
* Runs backend service

---

## 🧠 Summary

This project demonstrates:

* Deep understanding of AWS networking (VPC, subnets, routing)
* Manual infrastructure provisioning using Terraform
* Secure architecture using public/private subnet isolation
* Service-to-service communication via private networking
* Automation using user_data and systemd

---

## 📌 Future Improvements

* Refactor into Terraform modules
* Add Application Load Balancer (ALB)
* Add Auto Scaling Group
* Implement CI/CD pipeline

---

## 🔗 References

### Terraform

* [https://developer.hashicorp.com/terraform/docs](https://developer.hashicorp.com/terraform/docs)
* [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

### AWS

* [https://docs.aws.amazon.com/ec2/](https://docs.aws.amazon.com/ec2/)
* [https://docs.aws.amazon.com/vpc/](https://docs.aws.amazon.com/vpc/)

