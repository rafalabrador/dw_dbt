{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT DISTINCT
 {{ dbt_utils.generate_surrogate_key(['storeid']) }} as store_key,
storeid,
address as store_address, 
city as store_city, 
state as store_state,
zip as store_zip
FROM {{ source('samssubs_landing', 'store') }}