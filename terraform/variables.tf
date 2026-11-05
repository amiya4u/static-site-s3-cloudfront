#------------------------------------------------------------------------------
# Region
#------------------------------------------------------------------------------
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default = "us-east-1"
}

#------------------------------------------------------------------------------
# Website
#------------------------------------------------------------------------------
variable "website_index_document" {
  description = "Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders.  Defaults to index.html"
  type        = string
  default     = "index.html"
}
variable "website_error_document" {
  description = "(Optional) An absolute path to the document to return in case of a 4XX error. Defaults to 404.html"
  type        = string
  default     = "error.html"
}

#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_prefix" {
  description = "Name prefix for resources on AWS"
  default = "amiya-nov-2026"
}

