# User-data template

data "template_file" "userdata_hst" {
  template = "${file("./files/userdata_hst.template")}"

  vars {
    # HostsReg
    env_name  = "${var.env_name}"
    dns_zone  = "${var.dns_zone}"
    reg_token = "${var.reg_token}"
  }
}

# Launch configuration

resource "aws_launch_configuration" "rancher_hst" {
  image_id                    = "${lookup(var.ami_type, var.aws_region)}"
  instance_type               = "${var.hst_size}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.hst.id}", "${aws_security_group.gocd.id}", "${aws_security_group.splunk.id}", "${aws_security_group.sonarqube.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.rancher.id}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  user_data = "${data.template_file.userdata_hst.rendered}"
}

# Autoscaling group

resource "aws_autoscaling_group" "rancher_hst" {
  name                      = "${var.env_name}-hst"
  availability_zones        = ["${var.pub_sub_a}"]
  launch_configuration      = "${aws_launch_configuration.rancher_hst.name}"
  health_check_grace_period = 500
  health_check_type         = "EC2"
  max_size                  = "${var.hst_max}"
  min_size                  = "${var.hst_min}"
  desired_capacity          = "${var.hst_des}"
  vpc_zone_identifier       = ["${var.pub_sub_a}"]

  tag {
    key                 = "Name"
    value               = "${var.env_name}-hst"
    propagate_at_launch = true
  }

  depends_on = ["aws_launch_configuration.rancher_hst"]
}
