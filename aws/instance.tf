provider "aws" {
  region = "us-east-1"
}

variable "cli_user" {
  type = "string"
  default = "username ansible privilege 15 password ansible"
}

# Deploy CSRs. how did I get this AMI?
# Could optionally use the "count" option
resource "aws_instance" "tf_csr1" {
  ami = "ami-0d1e6af4c329efd82"
  instance_type = "t2.medium"
  key_name = "nickrus-kp"
  user_data = "ios-config-1=${var.cli_user}"
  root_block_device {
    delete_on_termination = true
  }
  tags = {
    Name = "tf_csr1"
  }

  # The provisioner below should be deleted
  provisioner "local-exec" {
    command = "echo '${aws_instance.tf_csr1.public_ip} csr1.njrusmc.net' | sudo tee -a /etc/hosts"
  }
}
