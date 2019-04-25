# Create a new DNS zone from the specified variable
resource "aws_route53_zone" "tf_dns_zone" {
  name = "${var.dns_zone}"
}

# Create a new A record for CSR1 using the newly-created DNS
# zone above and the EC2 public IP
resource "aws_route53_record" "tf_csr1_dns" {
  zone_id = "${aws_route53_zone.tf_dns_zone.zone_id}"
  name    = "csr1.${aws_route53_zone.tf_dns_zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.tf_csr1.public_ip}"]
}

# Repeat the process for CSR2
resource "aws_route53_record" "tf_csr2_dns" {
  zone_id = "${aws_route53_zone.tf_dns_zone.zone_id}"
  name    = "csr2.${aws_route53_zone.tf_dns_zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.tf_csr2.public_ip}"]
}
