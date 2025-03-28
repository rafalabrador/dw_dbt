{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT DISTINCT
    c.customer_key,
    e.employee_key,
    s.store_key, 
    p.product_key, 
    om.ordermethod_key,
    d.date_key,
    od.orderlineqty,
    od.orderlineprice,
    pc.productcost as productprice,
    od.pointsearned
FROM {{ source('samssubs_landing', '"ORDER"') }} o
INNER JOIN {{ source('samssubs_landing', 'orderdetails') }} od ON o.ordernumber = od.ordernumber
INNER JOIN {{ ref('sams_employee_dim') }} e ON  e.employeeid = o.employeeid
INNER JOIN {{ ref('sams_customer_dim') }} c ON c.customerid = o.customerid
INNER JOIN {{ ref('sams_product_dim') }} p ON p.productid = od.productid
INNER JOIN {{ ref('sams_date_dim') }} d ON d.date_id = o.orderdate
INNER JOIN {{ ref('sams_ordermethod_dim') }} om ON om.ordernumber = o.ordernumber
INNER JOIN {{ source('samssubs_landing', 'employee') }} eo ON eo.employeeid = e.employeeid
INNER JOIN {{ ref('sams_store_dim') }} s ON s.storeid = eo.storeid
INNER JOIN {{ source('samssubs_landing', 'product') }} pc ON pc.productid = p.productid