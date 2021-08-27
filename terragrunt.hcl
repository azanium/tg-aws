remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "tf-state-konvoloka"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "ap-southeast-1"
    encrypt = false
    dynamodb_table = "tf-lock-table-konvoloka"
  }
}