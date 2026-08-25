# SQL_data_analysis
SQL-based user engagement segmentation and churn analysis on PostgreSQL — segments users by early activity, calculates churn rate per segment, and identifies top engagement drivers, with a Python runner for end-to-end execution.

# User Engagement & Churn Analysis

A SQL and Python-based analytics project for analyzing mobile application user engagement and identifying users at risk of churn.

The project uses PostgreSQL event data to segment users based on their activity during the first seven days after signup and analyzes subsequent user behavior to calculate churn rates and identify common post-signup events.

## Objectives

- Segment users based on early engagement
- Calculate user churn rates
- Analyze post-signup user behavior
- Identify the most common events among highly engaged users
- Demonstrate Python-to-PostgreSQL integration

## User Segmentation

Users are classified as:

### Highly Engaged

Users who performed:

- At least 10 `app_open` events
- At least 3 `purchase` events

within their first 7 days after signup.

### Low Engagement

All other users.

## Churn Definition

A user is considered churned when they have not performed an `app_open` event during the last 30 days.

## Analysis

The project calculates:

- Total users per segment
- Churned users per segment
- Churn rate per segment
- Most common event type among highly engaged users between 30 and 60 days after signup

## Technology Stack

- PostgreSQL
- SQL / CTEs
- Python
- Pandas
- Psycopg2
- Python-dotenv

## Architecture

```text
PostgreSQL
    │
    ├── users
    │
    └── events
          │
          ▼
      SQL / CTEs
          │
          ▼
   User Segmentation
          │
          ▼
     Churn Analysis
          │
          ▼
   Event Analysis
          │
          ▼
       Pandas
          │
          ▼
    Console Report