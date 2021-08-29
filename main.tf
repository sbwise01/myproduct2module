resource "aws_s3_bucket" "web_bucket" {
  bucket        = "${var.environment}-product2-web-bucket"
  acl           = "public-read"
  force_destroy = true
  website {
    error_document = "error.html"
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "static_content_bucket" {
  bucket        = "${var.environment}-product2-static-content-bucket"
  acl           = "public-read"
  force_destroy = true
  website {
    error_document = "error.html"
    index_document = "index.html"
  }
}

resource "kubernetes_config_map" "s3_bucket_names" {
  metadata {
    name      = "product2-s3-bucket-names"
    namespace = "default"
  }

  data = {
    web_bucket            = aws_s3_bucket.web_bucket.id
    static_content_bucket = aws_s3_bucket.static_content_bucket.id
  }
}
