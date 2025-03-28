{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT 
 {{ dbt_utils.generate_surrogate_key(['p.productid']) }} as product_key,
p.productid,
p.producttype,
p.productname,
p.productcalories, 
s.breadtype
FROM {{ source('samssubs_landing', 'product') }} p 
    LEFT JOIN {{ source('samssubs_landing', 'sandwich') }} s
        ON p.productid = s.productid