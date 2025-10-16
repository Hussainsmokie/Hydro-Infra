########################################
# Bastion Host with EIP and IAM Role
########################################

# IAM Role for Bastion
resource "aws_iam_role" "bastion_role" {
  name = "bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment (Optional: SSM access)
resource "aws_iam_role_policy_attachment" "bastion_ssm" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance Profile
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion-instance-profile"
  role = aws_iam_role.bastion_role.name
}

# Bastion EC2 Instance
resource "aws_instance" "bastion" {
  ami                    = "ami-0f5ee92e2d63afc18" # Amazon Linux 2 AMI (ap-south-1)
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  key_name               = "hotstar"  # Change as per your setup

  tags = {
    Name = "bastion-host"
  }
}

# Elastic IP for Bastion
resource "aws_eip" "bastion_eip" {
  domain = "vpc"
  instance = aws_instance.bastion.id

  tags = {
    Name = "bastion-eip"
  }
}
