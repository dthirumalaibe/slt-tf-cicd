# Tells Terraform what region to use, as this default setting
# from "aws configure" does not carry over
provider "aws" {
  region = "us-east-1"
}

# This bootstrap configuration is applied to the routers when
# they are created, which allows Ansible to log in via SSH
variable "cli_user" {
  type = "string"
  default = "username ansible privilege 15 password ansible"
}

# Identifies the name of the DNS zone
variable "dns_zone" {
  type = "string"
  default = "zone.tf.test"
}
