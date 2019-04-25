# Create CSR1. The AMI was discovered using the AWS CLI command:
#   aws ec2 describe-images --filters 'Name=name,Values=cisco-CSR-*BYOL*'
# This particular AMI is for Cisco CSR1000v IOS-XE version 16.09.01
# The other data fields are basic AWS informational parameters. This
# includes deleting the volume upon destruction, setting a default
# key pair, and referencing the initial username and password setup data.
resource "aws_instance" "tf_csr1" {
  ami           = "ami-0d1e6af4c329efd82"
  instance_type = "t2.medium"
  key_name      = "nickrus-kp"
  user_data     = "ios-config-1=${var.cli_user}"
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

# Repeat the process for CSR2. It may make sense to use a different AMI to
# test alternative router versions as well.
resource "aws_instance" "tf_csr2" {
  ami           = "ami-0d1e6af4c329efd82"
  instance_type = "t2.medium"
  key_name      = "nickrus-kp"
  user_data     = "ios-config-1=${var.cli_user}"
  root_block_device {
    delete_on_termination = true
  }
  tags = {
    Name = "tf_csr2"
  }

  # The provisioner below should be deleted
  provisioner "local-exec" {
    command = "echo '${aws_instance.tf_csr2.public_ip} csr2.njrusmc.net' | sudo tee -a /etc/hosts"
  }
}
