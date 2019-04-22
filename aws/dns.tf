resource "aws_route53_zone" "tf_dns_zone" {
  name = "zone.tf.test"
}

# TODO update with proper DNS hostnames
resource "aws_route53_record" "tf_csr1_dns" {
  zone_id = "${aws_route53_zone.tf_dns_zone.zone_id}"
  name    = "csr1.${aws_route53_zone.tf_dns_zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.tf_csr1.public_ip}"]
}
