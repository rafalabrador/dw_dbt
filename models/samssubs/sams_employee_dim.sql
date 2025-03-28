{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT DISTINCT
 {{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employee_key,
employeeid,
employeefname, 
employeelname, 
employeebday
FROM {{ source('samssubs_landing', 'employee') }}