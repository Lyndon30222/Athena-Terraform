resource "aws_s3_object" "object" {
  depends_on = [
    aws_s3_bucket.athena-store
  ]

  bucket = aws_s3_bucket.athena-store.id
  key    = "data/athena-test-dataset-${random_string.this.id}"
  source = "data/dataset"

  etag = filemd5("data/dataset")
}
