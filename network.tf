variable "subnet_group" {
  description = "The existing subnet group name to use"
  type        = string
  validation {
    condition     = length(var.subnet_group) > 0
    error_message = "The subnet_group should contain the name."
  }
}

data "aws_db_subnet_group" "main" {
  name = var.subnet_group
}

locals {
  subnets = sort(distinct(compact(data.aws_db_subnet_group.main.subnet_ids)))
}

data "aws_subnet" "main" {
  count = length(local.subnets)
  id    = element(local.subnets, count.index)
}

data "aws_vpc" "main" {
  id = data.aws_subnet.main[0].vpc_id
}
