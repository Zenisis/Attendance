terraform {
  backend "s3" {
    bucket = "attendance-12"
    key    = "ecs/terraform.tfstate"
    region = "us-east-1"

  }
}
