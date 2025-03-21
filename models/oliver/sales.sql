{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    fs.customer_key,
    c.first_name AS customer_first_name,  -- Renamed to avoid conflict
    c.last_name AS customer_last_name,    -- Renamed to avoid conflict
    fs.date_key,
    d.date_id AS transaction_date,  -- Use human-readable full date
    fs.store_key, 
    s.store_name,
    fs.product_key, 
    p.product_name,
    p.description AS product_description,
    fs.employee_key,
    e.first_name AS employee_first_name,  -- Renamed to avoid conflict
    e.last_name AS employee_last_name,    -- Renamed to avoid conflict
    e.position AS employee_position,
    fs.quantity,
    fs.unit_price,
    fs.dollars_sold
FROM {{ ref('fact_sales') }} fs
LEFT JOIN {{ ref('oliver_dim_date') }} d ON fs.date_key = d.date_id
LEFT JOIN {{ ref('oliver_dim_customer') }} c ON fs.customer_key = c.customer_key
LEFT JOIN {{ ref('oliver_dim_store') }} s ON fs.store_key = s.store_key
LEFT JOIN {{ ref('oliver_dim_product') }} p ON fs.product_key = p.product_key
LEFT JOIN {{ ref('oliver_dim_employee') }} e ON fs.employee_key = e.employee_key
