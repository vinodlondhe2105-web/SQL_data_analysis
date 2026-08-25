-- ============================================================
-- 1. Create user segments
-- ============================================================

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
),

user_segments AS (
    SELECT
        user_id,

        CASE
            WHEN app_open_count >= 10
                 AND purchase_count >= 3
            THEN 'Highly Engaged'

            ELSE 'Low Engagement'
        END AS segment

    FROM user_activity
),

-- ============================================================
-- 2. Determine churn status
-- ============================================================

user_churn AS (
    SELECT
        us.user_id,
        us.segment,

        CASE
            WHEN MAX(
                CASE
                    WHEN e.event_type = 'app_open'
                    THEN e.event_timestamp
                END
            ) < CURRENT_TIMESTAMP - INTERVAL '30 days'

            OR MAX(
                CASE
                    WHEN e.event_type = 'app_open'
                    THEN e.event_timestamp
                END
            ) IS NULL

            THEN 1

            ELSE 0

        END AS churned

    FROM user_segments us

    LEFT JOIN events e
        ON us.user_id = e.user_id

    GROUP BY
        us.user_id,
        us.segment
)

-- ============================================================
-- 3. Churn rate by segment
-- ============================================================

SELECT
    segment,

    COUNT(*) AS total_users,

    SUM(churned) AS churned_users,

    ROUND(
        100.0 * SUM(churned) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM user_churn

GROUP BY
    segment

ORDER BY
    churn_rate_percent DESC;