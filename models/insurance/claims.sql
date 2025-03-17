{{ config(
    materialized = 'view',
    schema = 'dw_insurance'
) }}

SELECT
    fc.policy_key,
    fc.customer_key,
    fc.agent_key,
    fc.date_key,
    fc.ClaimAmount,
    d.date_day,
    d.month_of_year,
    d.year_number,
    c.firstname AS customer_first_name,
    c.lastname AS customer_last_name,
    a.firstname AS agent_first_name,
    a.lastname AS agent_last_name,
    p.policytype
FROM {{ ref('fact_claim') }} fc
INNER JOIN {{ ref('dim_date') }} d ON fc.date_key = d.date_key
INNER JOIN {{ ref('dim_customer') }} c ON fc.customer_key = c.customer_key
INNER JOIN {{ ref('dim_agent') }} a ON fc.agent_key = a.agent_key
INNER JOIN {{ ref('dim_policy') }} p ON fc.policy_key = p.policy_key
