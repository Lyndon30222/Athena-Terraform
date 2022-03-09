resource "aws_s3_bucket" "athena-store" {
  bucket = "${var.project_name}-${lower(random_string.this.id)}"
  force_destroy = true # allow terraform to destroy bucket even with items in
  tags = {
    Owner        = "YOURNAME"
  }
}

resource "aws_s3_bucket_public_access_block" "athena-store-block-public" {
  bucket = aws_s3_bucket.athena-store.id

  block_public_acls   = true
  block_public_policy = true
}