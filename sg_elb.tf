# Rancher ELB security group

resource "aws_security_group" "elb" {
  name        = "${var.env_name}-elb-sg"
  vpc_id      = "${var.vpc_id}"
  description = "Rancher ELB security group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_name}-elb-sg"
  }
}
