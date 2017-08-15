# Splunk security group

resource "aws_security_group" "splunk" {
  name        = "${var.env_name}-splunk-sg"
  vpc_id      = "${var.vpc_id}"
  description = "Splunk Security Group"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_name}-splunk-sg"
  }
}
