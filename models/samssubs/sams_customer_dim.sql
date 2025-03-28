{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT DISTINCT
 {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customer_key,
customerid,
customerfname, 
customerlname, 
customerbday,
customerphone
FROM {{ source('samssubs_landing', 'customer') }}