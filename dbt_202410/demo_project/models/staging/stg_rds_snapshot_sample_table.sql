-- This model is currently disabled by dbt_project.yml
with
    source as (select * from {{ source("rds_snapshot", "sample_table") }}),
    renamed as (
        select
            {{ adapter.quote("VALUE") }},
            {{ adapter.quote("ID") }},
            {{ adapter.quote("NAME") }},
            {{ adapter.quote("CREATED_AT") }},
            {{ adapter.quote("UPDATED_AT") }}

        from source
    )
select *
from renamed
