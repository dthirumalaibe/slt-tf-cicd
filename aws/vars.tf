provider "aws" {
  region = "us-east-1"
}

variable "cli_user" {
  type = "string"
  default = "username ansible privilege 15 password ansible"
}

variable "dns_zone" {
  type = "string"
  default = "zone.tf.test"
}
