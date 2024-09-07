output "hashicorp_user" {
  value = {
    trigger       = module.user.triggers
    username      = module.user.name
    primary_group = module.user.primary_group
    uids          = module.user.uid
    primary_gid   = module.primary_group.gid
  }
}
