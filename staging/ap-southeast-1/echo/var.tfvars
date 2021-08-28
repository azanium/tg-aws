  vpc_cidr            = "10.0.0.0/16"
  private_subnets     = ["10.0.0.0/20", "10.0.32.0/20"]
  public_subnets      = ["10.0.16.0/20", "10.0.48.0/20"]
  tsl_certificate_arn = "mycertificatearn"
  container_memory    = 512
  container_cpu       = 256
  container_port      = 80
  container_image     = "ealen/echo-server"
  availability_zones  = ["ap-southeast-1a", "ap-southeast-1b"]
  name                = "iou"
  region              = "ap-southeast-1"

  