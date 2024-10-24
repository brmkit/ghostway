terraform {
    required_providers {
      linode = {
        source  = "linode/linode"
        }
    }
}

provider "linode" {
    token = var.token_linode
}

resource "linode_instance" "backline_redirector" {
    image  = var.image_os
    label  = "backline"
    region = "eu-central"
    type   = var.instance_type
    root_pass = var.root_password

    connection {
      host = self.ip_address
      user = "root"
      password = var.root_password
    }

    provisioner "remote-exec" {
        inline = [ "hostnamectl set-hostname ${self.label}" ]
    }

    firewall_id = linode_firewall.protection_rules.id
}

resource "linode_instance" "midline_redirector" {
    image  = var.image_os
    label  = "midline"
    region = "au-mel"
    type   = var.instance_type
    root_pass = var.root_password
    
    connection {
      host = self.ip_address
      user = "root"
      password = var.root_password
    }

    provisioner "remote-exec" {
        inline = [ "hostnamectl set-hostname ${self.label}" ]
    }

    firewall_id = linode_firewall.protection_rules.id

}

resource "linode_instance" "frontline_redirector" {
    image  = var.image_os
    label  = "frontline"
    region = "id-cgk"
    type   = var.instance_type
    root_pass = var.root_password

    connection {
      host = self.ip_address
      user = "root"
      password = var.root_password
    }

    provisioner "remote-exec" {
        inline = [ "hostnamectl set-hostname ${self.label}" ]
    }

    firewall_id = linode_firewall.protection_rules.id

}

resource "linode_instance_config" "setup_backline" {
    depends_on = [ linode_instance.backline_redirector ]
    linode_id = linode_instance.backline_redirector.id
    label = "setup_backline"

    provisioner "local-exec" {
        working_dir = "../ansible/"
        command = "ansible-playbook -i inventory/hosts.ini -i '${linode_instance.backline_redirector.ip_address},' -e 'ansible_password=${var.root_password} zerotier_network_id=${var.zerotier_network_id}' main.yml"
        environment = {
          ZEROTOKEN = var.zerotier_token
        }
    } 
}

resource "linode_instance_config" "setup_midline" {
    depends_on = [ linode_instance_config.setup_backline ]
    linode_id = linode_instance.midline_redirector.id
    label = "setup_midline"

    provisioner "local-exec" {
        working_dir = "../ansible/"
        command = "ansible-playbook -i inventory/hosts.ini -i '${linode_instance.midline_redirector.ip_address},' -e 'ansible_password=${var.root_password} zerotier_network_id=${var.zerotier_network_id}' main.yml"
        environment = {
          ZEROTOKEN = var.zerotier_token
        }
    }
}

resource "linode_instance_config" "setup_frontline" {
    depends_on = [ linode_instance_config.setup_midline ]
    linode_id = linode_instance.frontline_redirector.id
    label = "setup_frontline"

    provisioner "local-exec" {
        working_dir = "../ansible/"
        command = "ansible-playbook -i inventory/hosts.ini -i '${linode_instance.frontline_redirector.ip_address},' -e 'ansible_password=${var.root_password} zerotier_network_id=${var.zerotier_network_id}' main.yml"
        environment = {
          ZEROTOKEN = var.zerotier_token
        }
    } 
}
