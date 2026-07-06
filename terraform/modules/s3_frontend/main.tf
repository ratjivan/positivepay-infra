resource "aws_s3_bucket" "frontend" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "index.html"
  source       = "${path.root}/../../files/index.html"
  #source      = "${path.root}/../../frontend/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.root}/../../files/index.html")

  #etag = filemd5("${path.root}/../../frontend/index.html")
}