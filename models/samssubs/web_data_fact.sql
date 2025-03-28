{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT
    d.date_key,
    et.eventtype_key,
    ts.trafficsource_key,
    pu.pageurl_key,
    COUNT(*) as hitcount
FROM {{ source('samssubs_web_landing', 'web_traffic_events') }} wte
INNER JOIN {{ ref('sams_date_dim') }} d ON  d.date_id = TO_DATE(wte.event_timestamp)
INNER JOIN {{ ref('eventtype_dim') }} et ON  et.eventtype = wte.event_name
INNER JOIN {{ ref('pageurl_dim') }} pu ON pu.pageurl = wte.page_url
INNER JOIN {{ ref('trafficsource_dim') }} ts ON ts.traffic_source = wte.traffic_source
GROUP BY all
