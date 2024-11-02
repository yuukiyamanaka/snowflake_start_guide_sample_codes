# アカウントレベルオブジェクト

resource "snowflake_database" "example_db" {
  name = "EXAMPLE_DB"
  // タスク関連のパラメータは一旦最小値を設定する
  suspend_task_after_num_failures          = 1
  user_task_managed_initial_warehouse_size = "XSMALL"
  user_task_timeout_ms                     = 60 * 60 * 1000 // 1 hour
}

resource "snowflake_storage_integration" "example_s3" {
  name                      = "EXAMPLE_S3"
  comment                   = "A storage integration for S3"
  type                      = "EXTERNAL_STAGE"
  enabled                   = true
  storage_allowed_locations = ["*"]
  storage_provider          = "S3"
  storage_aws_role_arn      = "arn:aws:iam::012345678910:role/snowflake-role" # FIXME
}

// データベースレベルオブジェクト
resource "snowflake_schema" "example_schema" {
  name     = "EXAMPLE_SCHEMA"
  database = snowflake_database.example_db.fully_qualified_name
}

// スキーマレベルオブジェクト

resource "snowflake_stage" "example_stage" {
  name                = "EXAMPLE_STAGE"
  url                 = "s3://your-bucket-name/export-task-id-xxxxx" # FIXME
  database            = snowflake_database.example_db.name
  schema              = snowflake_schema.example_schema.name
  storage_integration = snowflake_storage_integration.example_s3.name
}

resource "snowflake_file_format" "parquet_format" {
  name        = "PARQUET_FORMAT"
  database    = snowflake_database.example_db.name
  schema      = snowflake_schema.example_schema.name
  format_type = "PARQUET"
}
