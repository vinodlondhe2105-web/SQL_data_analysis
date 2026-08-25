from pathlib import Path

import pandas as pd


SQL_DIRECTORY = (
    Path(__file__).resolve().parent.parent / "sql"
)


def read_sql_file(filename: str) -> str:
    """
    Read SQL query from the sql directory.
    """

    file_path = SQL_DIRECTORY / filename

    if not file_path.exists():
        raise FileNotFoundError(
            f"SQL file not found: {file_path}"
        )

    return file_path.read_text(
        encoding="utf-8"
    )


def execute_query(connection, sql: str) -> pd.DataFrame:
    """
    Execute SQL query and return results as DataFrame.
    """

    return pd.read_sql_query(
        sql,
        connection,
    )


def get_churn_analysis(connection):
    """
    Execute churn analysis query.
    """

    sql = read_sql_file(
        "churn_analysis.sql"
    )

    return execute_query(
        connection,
        sql,
    )


def get_event_analysis(connection):
    """
    Execute 30-60 day event analysis.
    """

    sql = read_sql_file(
        "post_signup_event_analysis.sql"
    )

    return execute_query(
        connection,
        sql,
    )