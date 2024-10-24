variable "region" {
    default = "eu-central"
    description = "linode region"
}

variable "image_os" {
    default = "linode/ubuntu22.04"
    description = "default image for building instance"
}

variable "instance_type" {
    default = "g6-nanode-1"
    description = "default instance type - lowcost"
}

/*variable "authorized_keys" {
    default = [ "ssh-rsa AAAAB3Nza..." ]
    description = "generated authorized keys"
    sensitive = true
}*/

variable "root_password" {
    default = "do-not-use-password"
    description = "password for root account"
}

variable "token_linode" {
    default = "put-your-token"
    description = "Linode token"
}

variable "zerotier_network_id" {
    default = "put-your-net-id"
    description = "ZeroTier network id"
}

variable "zerotier_token" {
    default = "put-your-token"
    description = "ZeroTier Auth Token"
}

variable "teamserver" {
    default = "microsoft.com"
    description = "that's the teamserver server ip!"
}