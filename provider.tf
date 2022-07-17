terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "dataserver" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dataserver"
    location = "chicago"
  }
}

# Create Internet-Gateway
resource "aws_internet_gateway" "Databaseinternetgw" {
  vpc_id = aws_vpc.dataserver.id

  tags = {
    Name = "internet-gateway"
  }
}