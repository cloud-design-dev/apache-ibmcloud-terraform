# Overview
Building automation around infrastructure deployment can drastically reduce provisioning times and frequency of errors.  In this guide we will walk through automating the deployment of a vanilla apache web server using Terraform and Ansible. This is just a starting point, from which more customized solutions can be built.

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
* [IBM Cloud Classic IaaS Username / API Key](https://cloud.ibm.com/docs/account?topic=account-classic_keys)
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

![API Key](./static/api_key.png)

3. Update example file
We will need to update `terraform.tfvars.example` with our respective values, and then rename it so that Terraform picks up the variables. Check the file for comments on each item that should be updated. 
```
mv terraform.tfvars.example terraform.tfvars
```

> PLEASE NOTE! Though we are taking this approach for simplicity, storing secrets (such as API keys) in plaintext files is not best practice; it is highly recommended to use environment variables or some form of secrets management tooling (such as [openbao](https://github.com/openbao/openbao)) for real-world deployments.

4. Initialize Terraform
Setting the provider informs Terraform on which provider to pull configuration files for. Initializing Terraform is what bootstraps the configuration for any listed providers, so we do that here.
```
terraform init -upgrade
```

5. Create a Terraform plan
It is considered good practice to run terraform plan, save your Terraform execution to a plan file, in order to both review and encapsulate the proposed changes in a static file. Let's create the plan and output it to a file. Success here means that everything on Terraform's end is appropriate - any syntax errors should be noted and corrected.
```
terraform plan -out "out.tfplan"
```
![terraform plan -out "out.tfplan"](./static/tf-plan.png)

6. Apply the plan
Now that we have written and reviewed our planned changes, let's apply them based on the created file. Any errors here will not be from a Terraform configuration standpoint, but rather on the remote end that we're running the plan against.
```
terraform apply "out.tfplan"
```
![terraform apply "out.tfplan"](./static/test.jpg)

From here, you should see terraform work through each of your blocks in the `main.tf` file:
- `data "ibm_compute_ssh_key" "ssh_key"`: This retrieves the public SSH key we previously uploaded onto IBM Cloud. This will be imported into the system we're creating so that you may SSH in without a password. Do consider disabling password login for root after provisioning is complete.
- `resource "ibm_network_vlan" "apache_vlan"`: A private VLAN in a datacenter of your choice, defaulting to Dallas 13, for the new system to be provisioned on.
- `resource "ibm_compute_vm_instance" "apache_vm"`: The CentOS system we are deploying Apache on. Minimal specs are provided, and no default hostname or domain has been set. Many options for virtual servers can be found on the provider documentation [here](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_vm_instance)
- `module "ansible"` and `resource "null_resource" "ansible"`: These two tie our ansible portion into the terraform runtime, so that we can run the playbook directly from our terraform. The `local-exec` provisioner provides the direct command to run the playbook.
7. Test!
Either go to the IP address provided as an output from your terraform, or curl it to check the updated apache.

Retrieve IP address from Terraform:
```
terraform output
```
Check with cURL:
```
curl $(terraform output --raw vm_public_ip)
```

![curl](./static/test.jpg)
8. Clean up
When you're done testing and amending, clean up the workspace with terraform:
```
terraform destroy
```

![terraform destroy](./static/test.jpg)
And that's it! This is a simple example to deploy a CentOS server on IBM Cloud, and immediately bootstrap it with a custom Apache webpage. We hope that you can use this as a base to build your own custom solution using IBM, Terraform, and Ansible.

If you have any questions around this post, please direct your questions to john.bernhardt@ibm.com or aabdull@us.ibm.com
