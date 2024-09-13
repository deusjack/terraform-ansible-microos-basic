# Doesn't need a trigger. On change the playbooks is automatically replaced.
variable "hostname" {
  type        = string
  description = "The hostname of linux machine the directory will be created on"
}

variable "ntp_server" {
  type        = string
  description = "The default NTP server to use"
}
