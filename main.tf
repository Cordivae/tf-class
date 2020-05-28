provider "aws" {
  region = "us-west-2"
}

data "aws_region" "current" {}

terraform {
  backend "s3" {
    bucket         = "techmonkey-lab-2020-tf-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"

    dynamodb_table = "techmonkey-lab-tf-locks"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "terraform_state" { 
  bucket = "techmonkey-lab-2020-tf-state"

  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "techmonkey-lab-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
