resource "local_file" "ansible-inventory" {
    content = templatefile("${path.module}/inventory.tmpl",
        {
            hostname = var.hostname
            host_ip = var.host_ip
        }
    )
    filename="${path.module}/inventory.ini"
}