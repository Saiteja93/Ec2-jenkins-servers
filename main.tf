
# Security Group to allow SSH and port 8080
resource "aws_security_group" "allow_ssh_master" {
  name        = "allow_ssh_master"
  description = "Allow SSH inbound traffic and port 8080 for master"
  # vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ For testing only — lock to your IP for security
  }

    ingress {
    description = "jenkins port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ For testing only — lock to your IP for security
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow ssh and jenkins port"
  }
}


# Security Group to allow SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  # vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ For testing only — lock to your IP for security
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSSH"
  }
}

# EC2 Instance
resource "aws_instance" "terraform-one" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  # subnet_id                   = data.aws_subnet_ids.default.ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "jenkins-master"
  }
}

resource "aws_instance" "terraform-two" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_agent
  # subnet_id                   = data.aws_subnet_ids.default.ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh_master.id]

  tags = {
    Name = "jenkins-agent"
  }
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}