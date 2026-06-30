# Creates a single production-grade S3 bucket named bucket-deletion-2026 with BucketOwnerEnforced object ownership, all public access blocked, SSE-S3 (AES256) default encryption enabled, and versioning enabled in us-east-1.
# Generated Terraform code for AWS in us-east-1

terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.25.0"
    }
  }
}

variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket."
  type        = string
  default     = "bucket-deletion-2026"
  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "bucket_name must be between 3 and 63 characters."
  }
}

variable "tags" {
  description = "Tags to apply to all created resources."
  type        = map(string)
  default = {
    ManagedBy = "terraform"
  }
}

provider "aws" {
  region = var.region

  {{block_to_replace_cred}}
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "s3_bucket_id" {
  description = "ID (name) of the S3 bucket."
  value       = aws_s3_bucket.this.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket."
  value       = aws_s3_bucket.this.arn
}

output "s3_bucket_bucket_domain_name" {
  description = "Bucket domain name of the S3 bucket."
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "s3_bucket_ownership_controls_id" {
  description = "ID of the bucket ownership controls configuration."
  value       = aws_s3_bucket_ownership_controls.this.id
}

output "s3_bucket_public_access_block_id" {
  description = "ID of the public access block configuration."
  value       = aws_s3_bucket_public_access_block.this.id
}

output "s3_bucket_sse_configuration_id" {
  description = "ID of the server-side encryption configuration."
  value       = aws_s3_bucket_server_side_encryption_configuration.this.id
}

output "s3_bucket_versioning_id" {
  description = "ID of the versioning configuration."
  value       = aws_s3_bucket_versioning.this.id
}