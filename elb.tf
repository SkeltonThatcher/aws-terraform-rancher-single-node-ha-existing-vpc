# ELB creation

resource "aws_elb" "rancher" {
  name            = "${var.env_name}-elb"
  subnets         = ["${var.pub_sub_a}", "${var.pub_sub_b}"]
  security_groups = ["${aws_security_group.elb.id}"]

  listener {
    instance_port      = 8080
    instance_protocol  = "tcp"
    lb_port            = 443
    lb_protocol        = "ssl"
    ssl_certificate_id = "${var.ssl_arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 3
    target              = "TCP:8080"
    interval            = 10
  }
}

resource "aws_proxy_protocol_policy" "websockets" {
  load_balancer  = "${aws_elb.rancher.name}"
  instance_ports = ["8080"]
}
