# Overview

Building automation around infrastructure deployment can drastically reduce provisioning times and frequency of errors.  In this guide we will walk through automating the deployment of a vanilla apache web server using Terraform and Ansible. This is just a starting point, from which more customized solutions can be built.
> This repository has an associated blog post [here](https://community.ibm.com/community/user/cloud/blogs/jack-bernhardt/2024/07/11/terraform-deploying-an-apache-webserver-on-ibm-clo)

## The code in this example will:

- Create a Premium VLAN
- Create a CentOS virtual server
- Kick off an Ansible Playbook that will :
	* Install Httpd on the virtual server
	* Start the Httpd service
	* Install dependent libraries
	* Copy the site from your workstation to the newly created server

---

## Prerequisites

You will need to provision compute infrastructure on your IBM Cloud account in order to use the example code. IBM Cloud virtual server instances and bare metal servers can be ordered via your IBM Cloud account. Don’t have an IBM Cloud account yet? [Sign up here](https://cloud.ibm.com/registration).

* [Terraform installed](https://developer.hashicorp.com/terraform/install)
* [Ansible installed](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [IBM Cloud API Key](https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui#create_user_key)
* [IBM Cloud Classic IaaS SSH Key](https://cloud.ibm.com/docs/ssh-keys?topic=ssh-keys-adding-an-ssh-key#adding-an-ssh-key)

> This code is written to work with Terraform 0.13 and above. If you would like to work with multiple versions of Terraform on the same machine take a look at [tfswitch](https://github.com/warrensbox/terraform-switcher).

## Deploying the virtual server

1. Download example code
```
git clone https://github.com/cloud-design-dev/apache-ibmcloud-terraform
cd apache-ibmcloud-terraform
```

2. Load your SSH key
If you don't already have an SSH key pair generated and uploaded to your IBM Cloud account, we can do that here. We'll need the SSH public key in IBM Cloud so that your workstation can authenticate against the virtual server we create with terraform.
>Not sure if you have a key uploaded on IBM? Check [here](https://cloud.ibm.com/iam/apikeys).

Generate the SSH key
```
$ ssh-keygen -t ed25519 -b 4096
```

Add the public key to the [IBM Cloud portal](https://cloud.ibm.com/classic/devices/sshkeys) 

3. Update example file
```
mv terraform.tfvars.example terraform.tfvars
vi/nano/emacs terraform.tfvars
```

4. Initialize Terraform
```
terraform init -upgrade
```

5. Create a Terraform plan
```
terraform plan -out "out.tfplan"
```

6. Apply the plan
```
terraform apply "out.tfplan"
```
