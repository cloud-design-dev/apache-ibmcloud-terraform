variable "datacenter" {
    description = "Datacenter for server deployment"
    type = string
    default = "dal13"
}

variable iaas_classic_api_key {
    description = "Classic Infrastructure API Key: Required for authentication"
    type = string
}

variable iaas_classic_username {
    description = "Classic Infrastructure Username: Required for authentication"
    type = string
}

variable ssh_key {
    description = "Name of Classic Infrastructure SSH key"
    type = string
}

variable hostname {
    description = "Hostname of provisioned system"
    default = "apache-ibm"
    type = string
}

variable domain {
    description = "Domain of provisioned system"
    default = "example.com"
    type = string
}