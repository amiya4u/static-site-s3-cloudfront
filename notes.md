http://amiya-nov-2026-bucket.s3-website-us-east-1.amazonaws.com


- Too list CloudFront domain name
aws cloudfront list-distributions --query "DistributionList.Items[0].DomainName" --output text

- To delete files from AWS bucket 
aws s3 rm s3://amiya-nov-2026-bucket --recursive

- Shows all resources currently tracked in Terraform state
terraform state list
