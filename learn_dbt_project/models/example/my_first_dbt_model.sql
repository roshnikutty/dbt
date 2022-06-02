
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/


-- ephemeral tables are used for CTEs, they do not show up in snowflake and can be reused in many queries
-- sets up temporary tables that you can use in other models but does not get stored in Snowflake
--{{ config(materialized='ephemeral') }}


{{ config(materialized='table', alias='first_model') }}

with source_data as (
    select 1 as id
    union all
    select null as id

)

select *, '{{ var("my_first_variable") }}' as first_variable
from source_data
where id >= '{{ var("my_third_variable") }}'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
