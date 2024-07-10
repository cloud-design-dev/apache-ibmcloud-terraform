data "ibm_compute_ssh_key" "ssh_key" {
  label = var.ssh_key
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
  cores             = 2
  memory            = 2048
  private_vlan_id   = ibm_network_vlan.apache_vlan.id

  ssh_key_ids = ["${data.ibm_compute_ssh_key.ssh_key.id}"]

}

module "ansible" {
  source   = "./ansible"
  hostname = ibm_compute_vm_instance.apache_vm.hostname
  host_ip  = ibm_compute_vm_instance.apache_vm.ipv4_address
}

resource "null_resource" "ansible" {
  depends_on = [ibm_compute_vm_instance.apache_vm]
  provisioner "local-exec" {
    when    = create
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./ansible/inventory.ini ./ansible/apache.yaml"
  }
}
