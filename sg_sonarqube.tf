# Sonarqube security group

resource "aws_security_group" "sonarqube" {
  name        = "${var.env_name}-sonarqube-sg"
  vpc_id      = "${var.vpc_id}"
  description = "Sonarqube Security Group"

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_name}-sonarqube-sg"
  }
}
