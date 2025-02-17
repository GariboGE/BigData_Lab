FROM jupyter/pyspark-notebook:latest

COPY scripts /home/jovyan/scripts

USER root

RUN chmod +x /home/jovyan/scripts/check_connections.sh /home/jovyan/scripts/test_container.py

RUN apt-get update && apt-get install -y \
    libpq-dev \
    build-essential \
    libhdf5-dev \
    libsasl2-dev \
    mongodb-mongosh \
    postgresql-client \
    redis-tools \
    python3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libkrb5-dev \
    libz-dev \
    libjemalloc-dev \
    zlib1g-dev

USER jovyan

RUN pip install --no-cache-dir \
    pyspark pymongo psycopg2 redis sqlalchemy pyhive \
    pandas numpy dask modin \
    matplotlib seaborn plotly bokeh \
    scikit-learn xgboost lightgbm tensorflow keras \
    pyarrow hdfs3 fastparquet \
    numba cython joblib

EXPOSE 8888
