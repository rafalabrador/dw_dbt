{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT DISTINCT
 {{ dbt_utils.generate_surrogate_key(['page_url']) }} as pageurl_key,
page_url as pageurl
FROM {{ source('samssubs_web_landing', 'web_traffic_events') }}