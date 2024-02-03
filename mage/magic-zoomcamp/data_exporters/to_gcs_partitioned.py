from mage_ai.settings.repo import get_repo_path
from mage_ai.io.bigquery import BigQuery
from mage_ai.io.config import ConfigFileLoader
from pandas import DataFrame
from os import path
import os
import pyarrow.parquet as pq
import pyarrow as pa

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "/home/src/service-account.json"

project_id = "dezoomcamp-412116"
bucket_name = "bucket-for-de-zoomcamp"

table_name = "ny_taxi_data"

root_path = f'{bucket_name}/{table_name}'


@data_exporter
def export_data(data, *args, **kwargs):
    data['tpep_pickup_date'] = data['tpep_pickup_datetime'].dt.date

    table = pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path = root_path,
        partition_cols = ['tpep_pickup_date'],
        filesystem = gcs
    )
    
