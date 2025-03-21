{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.customer_key,
    d.date_key,
    s.store_key, 
    p.product_key, 
    e.employee_key,
    ol.quantity,
    o.total_amount AS dollars_sold,
    ol.unit_price
FROM {{ source('oliver_landing', 'orders') }} o
INNER JOIN {{ source('oliver_landing', 'orderline') }} ol ON o.order_id = ol.order_id
INNER JOIN {{ ref('oliver_dim_employee') }} e ON  e.employee_id = o.employee_id
INNER JOIN {{ ref('oliver_dim_customer') }} c ON c.customer_id = o.customer_id
INNER JOIN {{ ref('oliver_dim_product') }} p ON p.product_id = ol.product_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_id = o.order_date
INNER JOIN {{ ref('oliver_dim_store') }} s ON s.store_id = o.store_id
