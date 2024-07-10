output "vm_public_ip" {
  description = "Public IP of CentOS system"
  value       = ibm_compute_vm_instance.apache_vm.ipv4_address
}

output "vm_hostname" {
  description = "Hostname of CentOS system"
  value       = ibm_compute_vm_instance.apache_vm.hostname
}

