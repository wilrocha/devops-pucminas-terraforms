# VPC. 
resource "aws_vpc" "docker_server_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.prefix}-vpc"
    }
  )
}

# Internet Gateway.
resource "aws_internet_gateway" "docker_server_gateway" {
  vpc_id = aws_vpc.docker_server_vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.prefix}-ig"
    }
  )
}

# Rotas.
resource "aws_route" "docker_server_route" {
  route_table_id         = aws_vpc.docker_server_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.docker_server_gateway.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Subrede
resource "aws_subnet" "docker_server_subnet" {
  vpc_id                  = aws_vpc.docker_server_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.prefix}-subnet"
    }
  )
}