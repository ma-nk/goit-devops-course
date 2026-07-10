terraform {
  backend "s3" {
    bucket         = "goit-devops-lesson-5-state-yuriim"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
