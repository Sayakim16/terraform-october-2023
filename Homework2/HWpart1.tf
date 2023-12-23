provider "aws" {
    region = "us-east-2"
}
data "aws_ami" "amzn-linux-2023-ami" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name ="name"
        values = ["al2023-ami-2023.*-x86_64"]
    }
}

resource "aws_instance" "example" {
    ami     = data.aws_ami.amzn-linux-2023-ami.id
    instance_type = "t2.micro"
    availability_zone = "us-east-2a"
    vpc_security_group_ids = [aws_security_group.homework-sg.id]
    key_name = aws_key_pair.deployer.key_name
    user_data = file("httpd.sh")
    count = 1

    tags = {
        Name = "homework-ec2"
    }
}

resource "aws_security_group" "homework-sg" {
  name        = "homework-sg"
  description = "For HW-ec2"
  ingress {
    description      = "port22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "port80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}

ingress {
    description      = "port443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}

ingress {
    description      = "port3306"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
}
}

resource "aws_key_pair" "deployer" {
    key_name = "homework-key"
    public_key = file("~/.ssh/id_rsa.pub")
    
     tags = {
        Name = "homework-key"
    }
}