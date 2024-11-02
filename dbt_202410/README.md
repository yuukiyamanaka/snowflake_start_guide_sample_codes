# Setup
Set environment variables in `.env` according to the contents of `.env.sample`

```
cp .env.sample .env
```

Reopen in DevContainer

# Let's try

Please execute inside the DevContainer.

```
cd demo_project
dbt deps
dbt run
```

If you setup s3 integration correctly, you can run below to create external table.
```
dbt run-operation stage_external_sources --vars "ext_full_refresh: true"
```
