terraform {
  backend "s3" {
    bucket       = "goit-devops-lesson-7-state-yuriim"
    key          = "lesson-7/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}
