provider "aws" {
  region = "ap-south-1"
}

# ✅ VPC Setup
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "public_rta_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_security_group" "allow_all" {
  vpc_id = aws_vpc.main_vpc.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ Shared EC2 Instance for SonarQube, and Nexus
resource "aws_instance" "ci_cd_instance" {
  ami                    = "ami-06b6e5225d1db5f46" # Ubuntu 22.04 LTS
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  key_name               = "ci_cd"
  associate_public_ip_address = true

  tags = {
    Name = "CI-CD-Server"
  }
}

# ✅ EC2 Instance for Ansible
resource "aws_instance" "ansible_instance" {
  ami                    = "ami-06b6e5225d1db5f46"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  key_name               = "ansible"

  tags = {
    Name = "Ansible-Server"
  }
}

# ✅ EC2 Instance for Jenkins
resource "aws_instance" "jenkins_instance" {
  ami                    = "ami-06b6e5225d1db5f46"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  key_name               = "jenkins"

  tags = {
    Name = "Jenkins-Server"
  }
}

output "ci_cd_instance_ip" {
  value = aws_instance.ci_cd_instance.public_ip
}

output "ansible_instance_ip" {
  value = aws_instance.ansible_instance.public_ip
}
