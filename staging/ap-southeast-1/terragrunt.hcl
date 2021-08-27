inputs = {
  environment         = "staging"
  app_count           = 1
  name                = "konvoloka"
  region              = "ap-southeast-1"
  availability_zones  = ["ap-southeast-1a", "ap-southeast-1b"]
  vpc_cidr            = "10.0.0.0/16"
  private_subnets     = ["10.0.0.0/20", "10.0.32.0/20"]
  public_subnets      = ["10.0.16.0/20", "10.0.48.0/20"]
  tsl_certificate_arn = "mycertificatearn"
  container_memory    = 512
  container_cpu       = 256
  container_port      = 80
  container_image     = "ealen/echo-server"
}

include {
  # The find_in_parent_folders() helper will 
  # automatically search up the directory tree to find the root terragrunt.hcl and inherit 
  # the remote_state configuration from it.
  path = find_in_parent_folders()
}

terraform {
  source = "../../tf-modules"
  # source = "git::git@github.com:azanium/tf-fargate.git//?ref=v0.0.2"

  extra_arguments "conditional_vars" {
    # built-in function to automatically get the list of 
    # all commands that accept -var-file and -var arguments
    commands = get_terraform_commands_that_need_vars()

    # arguments = [
    #   "-lock-timeout=10m",
    #   "-var", "module=${path_relative_to_include()}"
    # ]

    required_var_files = [
      "${get_parent_terragrunt_dir()}/sensitive.tfvars"
    ]
  }
}
