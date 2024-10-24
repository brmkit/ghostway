# ghostway
A simple multi-layered redirector infrastructure glued together with automation.

### overview

Read the blog post: [ghostway-project](https://brmkit.github.io/2024/10/09/ghostway-project.html)

### setup
Before you begin, you must customize the configurations to fit your needs:

1. Define your variables in `terraform/terraform.tfvars` (refer to `terraform.tfvars.example` for an example).
2. Review and adjust `terraform/variables.tf` as necessary.

### prerequisite

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install -y python3 python3-pip unzip sshpass terraform
pip3 install ansible
```

### deploy

Follow these steps to set up your infrastructure:

1. Sign up for a [Linode](https://www.linode.com/) account.
2. Create a [ZeroTier](https://www.zerotier.com/) network.
3. Fill `terraform/terraform.tfvars`.
4. Execute the following commands:
```bash
cd terraform/
terraform init
terraform apply
```
5. *BONUS*: you can test it using `havoc.profile`

*note: don’t forget to specify the `teamserver` variables in `terraform/variables.tf` and `ansible/inventory/hosts.ini`*

## license
Ghostway is provided 'as is' under the MIT License.