locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "tf-state-konvoloka"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = local.region_vars.locals.region
    encrypt = false
    dynamodb_table = "tf-lock-table-konvoloka"
  }
}

inputs = merge(
  local.region_vars.locals,
  local.environment_vars.locals
)