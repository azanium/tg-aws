locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "../../../tf-modules/fargate"
  # source = "git::git@github.com:azanium/tf-fargate.git//?ref=v0.0.2"

  extra_arguments "conditional_vars" {
    # built-in function to automatically get the list of 
    # all commands that accept -var-file and -var arguments
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-lock-timeout=10m"
    ]

    required_var_files = [
      "./var.tfvars"
    ]
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                = "echo"
  availability_zones  = local.region_vars.locals.availability_zones
}