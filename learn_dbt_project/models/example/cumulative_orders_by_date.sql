{{ config(materialized='view') }}

-- A view materialization doesn't rebuild the data in Snowflake until it is queried

-- In this assignment, you will create a new transformation called cumulative_orders_by_date. 
-- The transformation should be built off of the "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" table. The goal of the query is to get 
-- the cumulative sales for the order date. For example, if the sales were $10 on January 1 and $25 on January 3, then the cumulative 
-- sales would be $10 and $35 for Jan 1 and Jan 3 respectively. 
-- HINT: If you need help with the actual query, take a look at https://docs.snowflake.com/en/sql-reference/functions-analytic.html


with data as (
    select
        to_date(o.o_orderdate) as day,
        o.o_totalprice as sales
    from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" o
)

select day, sum(sales) over (order by day asc rows between unbounded preceding and current row) "cumulative_totalprice"
from data
