resource "aws_security_group" "datasync-sg-mimx" {
  name        = "datasync-sg-mimx"
  description = "Datasync Security Group"
  vpc_id      = "vpc-2245365f"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All traffic"
  }

  ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "smb"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "datasync-agent-mimx-sg"
  }
}