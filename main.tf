data "ibm_compute_ssh_key" "existing_ssh_key" {
  label = var.existing_ssh_key
}

resource "ibm_network_vlan" "apache_vlan" {
  name       = "ibmcloud-apache"
  datacenter = var.datacenter
  type       = "PRIVATE"
}

resource "ibm_compute_vm_instance" "apache_vm" {
  hostname          = var.hostname
  domain            = var.domain
  os_reference_code = "CENTOSSTREAM_9_64"
  datacenter        = var.datacenter
  network_speed     = 100
  flavor_key_name   = "B1_2X4X25"
  private_vlan_id   = ibm_network_vlan.apache_vlan.id
  local_disk        = false
  ssh_key_ids       = [data.ibm_compute_ssh_key.existing_ssh_key.id]
}

module "ansible" {
  source   = "./ansible"
  hostname = ibm_compute_vm_instance.apache_vm.hostname
  host_ip  = ibm_compute_vm_instance.apache_vm.ipv4_address
}

resource "null_resource" "ansible_new_key" {
  depends_on = [ibm_compute_vm_instance.apache_vm]
  provisioner "local-exec" {
    when    = create
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./ansible/inventory.ini ./ansible/apache.yaml"
  }
}