WITH user_activity AS (
    SELECT
        u.user_id,

        COUNT(
            CASE
                WHEN e.event_type = 'app_open'
                THEN 1
            END
        ) AS app_open_count,

        COUNT(
            CASE
                WHEN e.event_type = 'purchase'
                THEN 1
            END
        ) AS purchase_count

    FROM users u

    LEFT JOIN events e
        ON u.user_id = e.user_id
        AND e.event_timestamp >= u.signup_date
        AND e.event_timestamp < u.signup_date + INTERVAL '7 days'

    GROUP BY
        u.user_id
)

SELECT
    user_id,
    app_open_count,
    purchase_count,

    CASE
        WHEN app_open_count >= 10
             AND purchase_count >= 3
        THEN 'Highly Engaged'

        ELSE 'Low Engagement'
    END AS segment

FROM user_activity;