



    
       with partner_group_points as (

        select months, partner, points_amount, "valid" as status
        from ref('my_distinct_partners')
    )

    SELECT
    months,
    partner,
    sum(points_amount) as points_amount,
    status
    FROM partner_group_points
    GROUP BY months,partner,status

    
