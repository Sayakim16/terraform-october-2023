terraform {
  backend "s3" {
    bucket = "test-ifadat"
    key    = "ohio/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "kaizen"
  }
}
