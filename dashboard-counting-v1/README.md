
# 🚀 Terraform AWS Dashboard-Counting App

Terraform project provisioning a secure AWS 2-tier architecture with a public dashboard service and private backend counting service using EC2, VPC, and systemd automation.

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
- AWS VPC (Public + Private Subnet)
- Security Groups
- Bash (user_data)
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

├── terraform.tfvars

├── scripts/

│   ├── dashboard-service.sh

│   └── counting-service.sh



---

## 📦 Modules Used

- [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)  
  Used to provision VPC, subnets, route tables, Internet Gateway, and NAT Gateway.

Other resources are defined directly:
- EC2 instances
- Security Groups
- Key Pair
- Outputs
- User data scripts

---

## 🔑 Key Features

- Dynamic Ubuntu AMI (no hardcoding)
- Secure VPC architecture (public + private subnet)
- Dashboard connects to backend via private IP
- Automated service setup using systemd
- Reusable Terraform design using prefix
- Infrastructure as Code (IaC) best practices

---

## 📋 Prerequisites

- Terraform installed
- AWS CLI configured
- AWS credentials (profile)

---

## ⚙️ Configuration

Edit `terraform.tfvars`:

```hcl
prefix        = "dashboard-counting"
region        = "ap-southeast-1"
instance_type = "t3.micro"
my_ip_cidr    = "YOUR_IP/32"
profile       = "master-programmatic-admin"
````

---

## 🚀 How to Run

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

---

## 🌐 Access Application

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

### Dashboard (Public)

* Accessible from internet (port 9002)
* SSH restricted to your IP

### Counting (Private)

* No public access
* Only accessible from Dashboard (via Security Group)

---

## ⚡ Services

### Dashboard Service

* Runs on port **9002**
* Calls Counting service via private IP

### Counting Service

* Runs on port **9003**
* Internal backend service

---

## 📤 Outputs

```bash
terraform output
```

Example:

dashboard_public_ip = "18.x.x.x"
dashboard_url       = "http://18.x.x.x:9002"
counting_private_ip = "172.16.x.x"

---

## 🛠 Setup Scripts

### Dashboard Script

* Downloads and installs dashboard service
* Configures systemd
* Connects to counting service via private IP

### Counting Script

* Downloads and installs counting service
* Configures systemd
* Runs internal backend service

---


## 🔗 References

### Terraform

* [https://developer.hashicorp.com/terraform/docs](https://developer.hashicorp.com/terraform/docs)
* [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [https://registry.terraform.io/providers/hashicorp/tls/latest/docs](https://registry.terraform.io/providers/hashicorp/tls/latest/docs)
* [https://registry.terraform.io/providers/hashicorp/local/latest/docs](https://registry.terraform.io/providers/hashicorp/local/latest/docs)

### AWS

* [https://docs.aws.amazon.com/ec2/](https://docs.aws.amazon.com/ec2/)
* [https://docs.aws.amazon.com/vpc/](https://docs.aws.amazon.com/vpc/)
* [https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html)

### Module

* [https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)


