import logging

from database import get_connection
from analysis import (
    get_churn_analysis,
    get_event_analysis,
)


logging.basicConfig(
    level=logging.INFO,
    format=(
        "%(asctime)s - "
        "%(levelname)s - "
        "%(message)s"
    ),
)


def main():

    connection = None

    try:

        connection = get_connection()

        print(
            "\n===== USER CHURN ANALYSIS =====\n"
        )

        churn_results = get_churn_analysis(
            connection
        )

        print(
            churn_results.to_string(
                index=False
            )
        )

        print(
            "\n===== MOST COMMON EVENT "
            "30-60 DAYS AFTER SIGNUP =====\n"
        )

        event_results = get_event_analysis(
            connection
        )

        print(
            event_results.to_string(
                index=False
            )
        )

    except Exception as exc:

        logging.error(
            "Analysis failed: %s",
            exc,
        )

        raise

    finally:

        if connection:
            connection.close()

            logging.info(
                "Database connection closed."
            )


if __name__ == "__main__":
    main()