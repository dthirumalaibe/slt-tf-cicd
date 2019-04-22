#
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "tf_vpc" {
  cidr_block = "203.0.113.0/24"
  tags = {
    Name = "tf_vpc"
  }
}

# how did we end up with ".id" below? use output?
resource "aws_subnet" "tf_net" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  cidr_block = "203.0.113.64/26"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_net"
  }
}

# Deploy CSRs
# Could optionally use the "count" option
resource "aws_instance" "tf_csr1" {
  ami = "ami-0d1e6af4c329efd82"
  instance_type = "t2.medium"
  subnet_id = "${aws_subnet.tf_net.id}"
  key_name = "nickrus-kp"
  root_block_device {
    delete_on_termination = true
  }
  tags = {
    Name = "tf_csr1"
  }
}

resource "aws_instance" "tf_csr2" {
  ami = "ami-0d1e6af4c329efd82"
  instance_type = "t2.medium"
  subnet_id = "${aws_subnet.tf_net.id}"
  key_name = "nickrus-kp"
  root_block_device {
    delete_on_termination = true
  }
  tags = {
    Name = "tf_csr2"
  }
}

output "tf_csr1_ip" {
  value = "${aws_instance.tf_csr1.public_ip}"
}

output "tf_csr2_ip" {
  value = "${aws_instance.tf_csr2.public_ip}"
}

resource "aws_route53_zone" "tf_dns_zone" {
  name = "zone.tf.test"
}

# TODO update with proper DNS hostnames
resource "aws_route53_record" "tf_csr1_dns" {
  zone_id = "${aws_route53_zone.tf_dns_zone.zone_id}"
  name    = "csr1.zone.tf.test"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.tf_csr1.public_ip}"]
}

resource "aws_route53_record" "tf_csr2_dns" {
  zone_id = "${aws_route53_zone.tf_dns_zone.zone_id}"
  name    = "csr2.zone.tf.test"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.tf_csr2.public_ip}"]
}

#resource "null_resource" "ntp_config" {
#  provisioner "local-exec" {
#    command = "ansible-playbook ntp_config.yml"
#  }
#}
