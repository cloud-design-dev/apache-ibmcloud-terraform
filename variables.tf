variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
  type        = string
  sensitive   = true
}

variable "datacenter" {
  description = "Datacenter for server deployment"
  type        = string
  default     = "dal13"
}

variable "existing_ssh_key" {
  description = "Name of Classic Infrastructure SSH key"
  type        = string
  default     = ""
}

variable "hostname" {
  description = "Hostname of provisioned system"
  default     = "apache-ibm"
  type        = string
}

variable "domain" {
  description = "Domain of provisioned system"
  default     = "example.com"
  type        = string
}