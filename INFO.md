<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.66.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | >= 1.66.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ansible"></a> [ansible](#module\_ansible) | ./ansible | n/a |

## Resources

| Name | Type |
|------|------|
| [ibm_compute_vm_instance.apache_vm](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_vm_instance) | resource |
| [ibm_network_vlan.apache_vlan](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/network_vlan) | resource |
| [null_resource.ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [ibm_compute_ssh_key.ssh_key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/compute_ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | Datacenter for server deployment | `string` | `"dal13"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain of provisioned system | `string` | `"example.com"` | no |
| <a name="input_existing_ssh_key"></a> [existing\_ssh\_key](#input\_existing\_ssh\_key) | Name of Classic Infrastructure SSH key | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of provisioned system | `string` | `"apache-ibm"` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud API Key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_hostname"></a> [vm\_hostname](#output\_vm\_hostname) | Hostname of CentOS system |
| <a name="output_vm_public_ip"></a> [vm\_public\_ip](#output\_vm\_public\_ip) | Public IP of CentOS system |
<!-- END_TF_DOCS -->