# module-microos-basic
Terraform module for configuring the basics on MicroOS with Ansible

> [!Warning]
> * This module doesn't have resources with a traditional state.
> * Make sure to set var.external_triggers for any changes that require an update other than variables.
> * This module doesn't delete the changes on the target system on destroy.

# Terraform Docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_ansible"></a> [ansible](#requirement\_ansible) | >= 1, < 2 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2, < 3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3, < 4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3, < 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hostname"></a> [hostname](#module\_hostname) | git@github.com:deusjack/module-hostname.git | 1.0.0 |
| <a name="module_kernel"></a> [kernel](#module\_kernel) | git@github.com:deusjack/module-zypper.git | 1.0.0 |
| <a name="module_primary_group"></a> [primary\_group](#module\_primary\_group) | git@github.com:deusjack/module-group.git | 1.0.0 |
| <a name="module_software"></a> [software](#module\_software) | git@github.com:deusjack/module-zypper.git | 1.0.0 |
| <a name="module_systemd-timesyncd"></a> [systemd-timesyncd](#module\_systemd-timesyncd) | git@github.com:deusjack/module-systemd.git | 1.0.0 |
| <a name="module_user"></a> [user](#module\_user) | git@github.com:deusjack/module-user.git | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [random_id.hostid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname of linux machine the directory will be created on | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hashicorp_user"></a> [hashicorp\_user](#output\_hashicorp\_user) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
