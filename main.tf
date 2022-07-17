# create privatesubnet1

resource "aws_subnet" "datasbPR1" {
  vpc_id     = aws_vpc.dataserver.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "dataprivate1SB"
  }
}

# Create Priavtesubnet2

resource "aws_subnet" "datasbPR2" {
  vpc_id     = aws_vpc.dataserver.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "dataprivate2SB"
  }
}

 #Create Public subnet1

resource "aws_subnet" "datasbPB1" {
  vpc_id     = aws_vpc.dataserver.id
  cidr_block = "10.10.3.0/24"

  tags = {
    Name = "datapublic1SB"
  }
}

# Create Route-Table for Public subnet

resource "aws_route_table" "databaseRT" {
  vpc_id = aws_vpc.dataserver.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Databaseinternetgw.id
  }

  tags = {
    Name = "Public-RouteTB"
  }
}

# Associate Public Route Table to Public Subnet

resource "aws_route_table_association" "routeTbwithSN" {
  subnet_id      = aws_subnet.datasbPB1.id
  route_table_id = aws_route_table.databaseRT.id
}


# Create Private Route Table for private subnet

resource "aws_route_table" "datarouteprivate" {
  vpc_id = aws_vpc.dataserver.id

  route = []

  tags = {
    Name = "Routetable"
  }
}







