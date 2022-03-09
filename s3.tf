resource "aws_s3_bucket" "athena-store" {
  bucket = "lyndon30222-athena-store-${lower(random_string.this.id)}"
  force_destroy = true # allow terraform to destroy bucket even with items in
  tags = {
    Owner        = "Lyndon30222"
  }
}

resource "aws_s3_bucket_public_access_block" "athena-store-block-public" {
  bucket = aws_s3_bucket.athena-store.id

  block_public_acls   = true
  block_public_policy = true
}