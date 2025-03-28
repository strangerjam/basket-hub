from datetime import datetime

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator

from nba_api.stats.library.parameters import LeagueID

dag = DAG(
    dag_id='league',
    start_date=datetime(2025, 1, 1),
    schedule='@daily'
)

# # Set dependencies between tasks
# hello >> airflow()

def get_league_id(league):
    if league == 'nba':
        return LeagueID.nba

find_league_id = PythonOperator(
    task_id='find_league_id',
    python_callable=get_league_id,
    dag=dag
)

insert_to_league_table = SQLExecuteQueryOperator(
    task_id='create_pet_table',
    sql="""
        INSERT INTO league (external_code, code, name) VALUES
        ('00', 'nba', 'NBA'),
        ('10', 'wnba', 'WNBA');
    """,
    dag=dag
)

find_league_id >> insert_to_league_table