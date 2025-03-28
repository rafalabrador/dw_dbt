{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT DISTINCT
 {{ dbt_utils.generate_surrogate_key(['event_name']) }} as eventtype_key,
event_name as eventtype
FROM {{ source('samssubs_web_landing', 'web_traffic_events') }}