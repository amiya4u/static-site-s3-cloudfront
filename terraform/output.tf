output "access_key_id" {
  value = aws_iam_access_key.github_actions.id
}
output "secret_access_key" {
  value = aws_iam_access_key.github_actions.secret
  sensitive = true
}
output "bucket_name" {
  value = aws_s3_bucket.my_bucket_website.bucket
}
output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.website.id
}
