provider "aws" {
  region  = "us-west-2"
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}