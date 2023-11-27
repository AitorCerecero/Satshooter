data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "key-set" {
  key_name = "UniKey"
}

resource "aws_instance" "satsystem" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.satshooter-sg.id]
  key_name = data.aws_key_pair.key-set.key_name
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt install docker.io -y
              sudo apt install python3-pip -y
              sudo pip3 install psutil flask
              git clone https://github.com/AitorCerecero/Satshooter
              sudo docker build -t satshooter-flask .
              sudo docker run -p 5000:5000 satshooter-flask
              EOF
  tags = {
    Name = "satshooter-services"
  }
}