provider "aws" {
  region = var.region
}

#------------------------------------------------------------------------------
# Website S3 Bucket
#------------------------------------------------------------------------------ 
resource "aws_s3_bucket" "my_bucket_website" {
  bucket = "${var.name_prefix}-bucket"
}
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.my_bucket_website.id

  index_document {
    suffix = var.website_index_document
  }

  error_document {
    key = var.website_error_document
  }

}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my_bucket_website.id
  ignore_public_acls      = false
  block_public_acls       = false
  restrict_public_buckets = false
  block_public_policy     = false
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.my_bucket_website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_bucket_website.arn}/*"
      }
    ]
  })
}

#------------------------------------------------------------------------------
# Cloudfront for S3 Bucket Website
#------------------------------------------------------------------------------

resource "aws_cloudfront_distribution" "website" {
  origin {
  domain_name = aws_s3_bucket_website_configuration.example.website_endpoint
  origin_id   = "S3-my-bucket-website"
  
  custom_origin_config {
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "http-only"
    origin_ssl_protocols   = ["TLSv1.2"]
  }
}
  enabled = true
  default_root_object = "index.html"
  default_cache_behavior {
  allowed_methods        = ["GET", "HEAD"]
  cached_methods         = ["GET", "HEAD"]
  target_origin_id       = "S3-my-bucket-website"
  viewer_protocol_policy = "redirect-to-https"

  forwarded_values {
    query_string = false
    cookies {
      forward = "none"
    }
  }
}
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }

}

#------------------------------------------------------------------------------
# IAM User for GitHub Actions
#------------------------------------------------------------------------------
resource "aws_iam_user" "github_actions" {
  name = "${var.name_prefix}-github-actions"
}

resource "aws_iam_access_key" "github_actions" {
  user = aws_iam_user.github_actions.name
}
