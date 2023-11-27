resource "aws_security_group" "satshooter-sg" {
  name_prefix = "echo 2"

tags = {
    Name = "satshooter-security-group"
  }
}

resource "aws_security_group_rule" "http-trafic" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.satshooter-sg.id
}

resource "aws_security_group_rule" "flask-traffic" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.satshooter-sg.id
}

resource "aws_security_group_rule" "downloads" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.satshooter-sg.id
}