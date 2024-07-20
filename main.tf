provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "foo" {
  ami           = "ami-032346ab877c418af"  # Amazon Linux 2
  instance_type = "t2.micro"
  tags = {
    Name = "TF-Instance"
  }
}


