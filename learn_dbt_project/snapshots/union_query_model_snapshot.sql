{% snapshot union_query_model_snapshot %}
    {{
        config(
            target_database='analytics',
            target_schema='snapshots',
            unique_key='id',

            strategy='timestamp',
            updated_at='updated_at',
        )

    }}

    select * from {{ ref('model_for_snapshot') }}

{% endsnapshot %}