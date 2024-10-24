resource "linode_firewall" "protection_rules" {
  label = "protection_rules"

  inbound_policy = "DROP" 
  outbound_policy = "ACCEPT"

  # SSH
  inbound {
    label    = "SSH"
    action   = "ACCEPT"
    protocol = "TCP"
    ports     = 22
    ipv4     = ["0.0.0.0/0"]
  }

  # HTTP
  inbound {
    label    = "HTTP"
    action   = "ACCEPT"
    protocol = "TCP"
    ports     = 80
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

# UDP
  outbound {
    label     = "UDP"
    action    = "DROP"
    protocol  = "UDP"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

}
