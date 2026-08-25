import logging

import psycopg2

from config import DB_CONFIG


logger = logging.getLogger(__name__)


def get_connection():
    """
    Create and return a PostgreSQL database connection.
    """

    try:
        connection = psycopg2.connect(
            **DB_CONFIG
        )

        logger.info(
            "Successfully connected to PostgreSQL"
        )

        return connection

    except psycopg2.Error as exc:
        logger.error(
            "Failed to connect to PostgreSQL: %s",
            exc,
        )

        raise