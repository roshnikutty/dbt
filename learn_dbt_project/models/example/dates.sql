{{ config(materialized='incremental', unique_key='d_date') }}


-- for this particular sample snowflake table, there is one row is for every day
--  such that d_date is the unique key
select * 
from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."DATE_DIM"
where d_date <= current_date

-- for the first run, the entire table of 40k plus rows are updated, then only new date data
-- if this is an incremental view, and d_date is greater than the latest run of this current table, the sql will run
-- instead of d_date, updated_on or created_on dates can be used too
{% if is_incremental() %}
    and d_date > (select max(d_date) from {{this}})
{% endif %}