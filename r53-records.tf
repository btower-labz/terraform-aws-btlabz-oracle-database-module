variable "zone_id" {
  description = "R53 Hosted Zone ID"
  type        = string
}

variable "r53_name" {
  description = "Override default R53 name with this alias"
  type        = string
  default     = ""
}

variable "r53_aliases" {
  description = "Additional aliases to create in the R53 zone"
  type        = list(string)
  default     = []
}

variable "r53_ttl" {
  description = "TTL for R53 records."
  type        = number
  default     = 60
}

locals {
  r53_aliases = sort(distinct(compact(var.r53_aliases)))
}

resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.r53_name == "" ? var.name : var.r53_name
  type    = "CNAME"
  ttl     = var.r53_ttl
  records = [
    aws_db_instance.main.endpoint
  ]
}

resource "aws_route53_record" "alias" {
  count   = length(local.r53_aliases) > 0 ? length(local.r53_aliases) : 0
  zone_id = var.zone_id
  name    = element(local.r53_aliases, count.index)
  type    = "CNAME"
  ttl     = var.r53_ttl
  records = [
    aws_db_instance.main.endpoint
  ]
}
