{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT DISTINCT
 {{ dbt_utils.generate_surrogate_key(['ordernumber']) }} as ordermethod_key,
ordernumber,
ordermethod
FROM {{ source('samssubs_landing', '"ORDER"') }}