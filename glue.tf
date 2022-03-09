# to create an athena table it needs to be assigned to a database.
# multiple tables can share a database so this could be a passed in variable
resource "aws_glue_catalog_database" "athena-glue-database" {
  name = "lyndon-30222-glu-db"
}

# table set up to look in the /data folder of the s3 bucket we created
# table to set up to read JSON (kinda)
resource "aws_glue_catalog_table" "athena-glue-table" {
  depends_on    = [aws_glue_catalog_database.athena-glue-database]
  name          = "lyndon-30222-glu-table"
  database_name = aws_glue_catalog_database.athena-glue-database.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL = "TRUE"
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.athena-store.id}/data/" # look in data folder
    input_format  = "org.apache.hadoop.mapred.TextInputFormat" # read file(s) as plain text, split by line
    output_format = "org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "lyndon-30222-stream"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe" # used to deserialise json

      parameters = {
        "serialization.format" = 1
      }
    }

    dynamic "columns" {
      for_each = var.athena_columns

      content {
        name = columns.key
        type = columns.value
      }
    }
  }
}
