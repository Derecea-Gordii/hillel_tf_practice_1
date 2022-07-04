resource "aws_s3_bucket" "bucket"{
  bucket   = "hillel-18-derecea"
  # acl      = "private"

  # versioning {
  #   enabled = true
  # }
}

# resource "aws_ec2_instance" "instance"{
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"

#   name = "single-instance"

#   ami                    = "ami-09a41e26df464c548"
#   instance_type          = "t2.micro"
#   key_name               = "user"
#   monitoring             = true
#   vpc_security_group_ids = ["sg-0a3820e5f0a0701c9"]
#   subnet_id              = "subnet-0237aa5611a1ce56d"

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
  
# }

resource "aws_vpc" "my_vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "hl_18" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["192.168.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "hl_18" {
  ami           = "ami-09a41e26df464c548" # us-east-1
  instance_type = "t2.micro"
  user_data = "user_data.sh"

  network_interface {
    network_interface_id = aws_network_interface.hl_18.id
    device_index         = 0

  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}

