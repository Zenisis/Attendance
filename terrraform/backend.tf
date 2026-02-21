terraform {
  backend "s3" {

    bucket = "dusranaav"

   
    key    = "ecs/terraform.tfstate"
    region = "ap-south-1"
    # dynamodb_table = "terraform_locks"
    # encrypt = true

  }
}
