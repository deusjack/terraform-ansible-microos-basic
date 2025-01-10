module "software" {
  source   = "git@github.com:deusjack/terraform-ansible-zypper.git?ref=1.0.0"
  hostname = var.hostname
  packages = [
    "bash-completion",
    "bind-utils",
    "cnf",
    "cnf-bash",
    "curl",
    "duf",
    "htop",
    "jq",
    "nano",
    "policycoreutils-python-utils",
    "python3-rpmconf",
    "sensors",
    "xfsprogs"
  ]
}

module "kernel" {
  depends_on         = [module.software]
  source             = "git@github.com:deusjack/terraform-ansible-zypper.git?ref=1.0.0"
  hostname           = var.hostname
  packages           = ["kernel-longterm"]
  packages_uninstall = ["kernel-default"]
}

resource "random_id" "hostid" {
  byte_length = 4
}

module "hostname" {
  depends_on = [module.kernel]
  source     = "git@github.com:deusjack/terraform-ansible-hostname.git?ref=1.0.0"
  hostname   = var.hostname
  hostid     = random_id.hostid.hex
}

module "primary_group" {
  depends_on      = [module.kernel]
  source          = "git@github.com:deusjack/terraform-ansible-group.git?ref=1.0.0"
  hostname        = var.hostname
  name            = "hashicorp"
  gid             = 1000
  is_system_group = true
}

module "user" {
  source            = "git@github.com:deusjack/terraform-ansible-user.git?ref=1.0.0"
  hostname          = var.hostname
  name              = "hashicorp"
  uid               = 100
  comment           = "User for Hashicorp podman containers"
  primary_group     = module.primary_group.name
  create_home       = true
  is_system_user    = true
  external_triggers = module.primary_group.triggers
}

module "timesyncd_dir" {
  depends_on = [module.kernel]
  source     = "git@github.com:deusjack/terraform-ansible-directory.git?ref=1.0.0"
  hostname   = var.hostname
  path       = "/etc/systemd/timesyncd.conf.d"
  mode       = "0755"
  secontext = {
    type = "systemd_conf_t"
  }
}

module "timesyncd_conf" {
  source   = "git@github.com:deusjack/terraform-ansible-file.git?ref=1.0.0"
  hostname = var.hostname
  content = templatefile("${path.module}/ntp.conf.tftpl", {
    NTP_SERVER = var.ntp_server
  })
  path = "${module.timesyncd_dir.path}/ntp.conf"
  mode = "0644"
  secontext = {
    type = "systemd_conf_t"
  }
}

module "systemd_timesyncd" {
  depends_on = [module.timesyncd_conf]
  source     = "git@github.com:deusjack/terraform-ansible-systemd.git?ref=1.0.0"
  hostname   = var.hostname
  unit_name  = "systemd-timesyncd"
  unit_type  = "service"
}
