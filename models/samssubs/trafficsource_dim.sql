{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT DISTINCT
 {{ dbt_utils.generate_surrogate_key(['traffic_source']) }} as trafficsource_key,
traffic_source
FROM {{ source('samssubs_web_landing', 'web_traffic_events') }}