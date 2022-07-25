{%- call statement('my_statement', fetch_result=True) -%}
      SELECT count(distinct partner_name) FROM `genuine-display-356209.dbt_amadan.my_distinct_partners`
{%- endcall -%}

{%- set partner_count = load_result('my_statement')['data'][0][0] -%}

{% set partners = dbt_utils.get_column_values(table=ref('my_distinct_partners'),
       column='partner_name', max_records=50) %}

{% if partner_count == 3 %}
    {% if partners != '' %}

    with partner_group_points as (

        {% for partner in partners %}

            SELECT
                TO_CHAR( TO_DATE(points_timestamp, 'YYYY-MM-DD'), 'YYYY-MM') AS "months",
                '{{partner}}' as partner,
                SUM(points_amount) AS "points_amount",
                <custom calculation for status here> as status
            FROM
                `{{ target.project }}.platform_data_{{partner}}.raw_points`
            GROUP BY
                months,
                points_amount,
                status
            ORDER BY months DESC
            {% if not loop.last %} UNION ALL {% endif %}

        {% endfor %}
    )

    SELECT
    months,
    partner,
    sum(points_amount) as points_amount,
    status
    FROM partner_group_points
    GROUP BY months,partner,status

    {% endif %}
{% endif %}
