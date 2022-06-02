{{ config(materialized='view') }}

Select c.c_custkey, c.c_name, c.c_nationkey,
    SUM(o.o_totalprice) as sum_total
    FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER" c
    LEFT JOIN "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" o
    ON c.c_custkey = o.o_custkey
    GROUP BY c.c_custkey, c.c_name, c.c_nationkey