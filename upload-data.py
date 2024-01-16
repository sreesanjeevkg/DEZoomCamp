import pandas as pd
from sqlalchemy import create_engine

df = pd.read_csv("green_tripdata_2019-09.csv")

print(pd.io.sql.get_schema(df, name="yellowTaxiData"))