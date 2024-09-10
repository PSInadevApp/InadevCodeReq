terraform {
    backend "s3" {
        bucket = "inadevappbucket"
        key = "EKS/terraform.tfstate"
        region = "us-east-2"
    }
}