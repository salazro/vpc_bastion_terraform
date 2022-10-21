variable "accesskey" { type = string }

variable "secretkey" { type = string }

variable "mykeypair" { type = string }

# Availability Zone Variable List
variable "az" { type = list(any) }

# CIDR Block Variable List
variable "cidrA" { type = list(any) }

variable "cidrB" { type = list(any) }

variable "cidrC" { type = list(any) }

# A4L Subnet Variable List per Availability Zone
variable "subnet_nameA" { type = list(any) }

variable "subnet_nameB" { type = list(any) }

variable "subnet_nameC" { type = list(any) }

# Needed for IPV6 CIDR Block auto assignment
variable "ipv6_A" { type = list(any) }

variable "ipv6_B" { type = list(any) }

variable "ipv6_C" { type = list(any) }


