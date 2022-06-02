-- Using the "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM" table, create a model called 
-- incremental_time that selects all columns from the table only if the  t_time value is less than or equal 
-- to the time now. On incremental runs, you should only add times that don't already exist in your target 
--  incremental_time Snowflake table.

{{ config(materialized = 'incremental', unique_key='t_time')}}

select * 
    from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
    where to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) <= current_time

{% if is_incremental() %}
   and to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) > (select 
    max(to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND))) 
    from {{this}})
{% endif %}