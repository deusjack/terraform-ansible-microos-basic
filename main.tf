module "software" {
  source   = "git@github.com:deusjack/module-zypper.git?ref=1.0.0"
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
    "xfsprogs"
  ]
}

module "kernel" {
  depends_on         = [module.software]
  source             = "git@github.com:deusjack/module-zypper.git?ref=1.0.0"
  hostname           = var.hostname
  packages           = ["kernel-longterm"]
  packages_uninstall = ["kernel-default"]
}

resource "random_id" "hostid" {
  byte_length = 4
}

module "hostname" {
  depends_on = [module.kernel]
  source     = "git@github.com:deusjack/module-hostname.git?ref=1.0.0"
  hostname   = var.hostname
  hostid     = random_id.hostid.hex
}

module "primary_group" {
  depends_on      = [module.kernel]
  source          = "git@github.com:deusjack/module-group.git?ref=1.0.0"
  hostname        = var.hostname
  name            = "hashicorp"
  gid             = 1000
  is_system_group = true
}

module "user" {
  source            = "git@github.com:deusjack/module-user.git?ref=1.0.0"
  hostname          = var.hostname
  name              = "hashicorp"
  uid               = 100
  comment           = "User for Hashicorp podman containers"
  primary_group     = module.primary_group.name
  create_home       = true
  is_system_user    = true
  external_triggers = module.primary_group.triggers
}
