from pendulum import datetime
from airflow import DAG
from airflow.providers.cncf.kubernetes.operators.kubernetes_pod import (
    KubernetesPodOperator,
)

with DAG(
    dag_id="pcaf_dbt_transformation",
    schedule="@once",
    start_date=datetime(2024, 11, 5),
) as dag:
    pcaf_dbt_transformation = KubernetesPodOperator(
        namespace='datamesh-demo',
        image="quay.io/osclimate/osclimate-pcaf-dbt:1.0",
        name="pcaf-dbt-transformation-k8pod1",
        task_id="generate_dbt_docs_aws_k8",
        is_delete_operator_pod=False,
        get_logs=True,
        service_account_name='airflow',
        hostnetwork=False,
        startup_timeout_seconds=1000
    )

    pcaf_dbt_transformation
