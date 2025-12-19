# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets of default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get default security group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# Create Free Tier EC2
resource "aws_instance" "nano" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  key_name      = var.key_name

  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [data.aws_security_group.default.id]
  associate_public_ip_address = true

  tags = {
    Name = "terraform-free-ec2"
  }
}

output "public_ip" {
  value = aws_instance.nano.public_ip
}

