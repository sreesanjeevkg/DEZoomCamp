FROM python:3.9.1

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app
COPY IngestionPipeline.py ingest_data.py 
COPY taxi+_zone_lookup.csv taxi+_zone_lookup.csv

ENTRYPOINT [ "python", "ingest_data.py" ]