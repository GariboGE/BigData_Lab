import pymongo
import psycopg2
import redis
from pyspark.sql import SparkSession
from psycopg2 import OperationalError
from pymongo.errors import ConnectionFailure
from redis.exceptions import ConnectionError

def test_spark():
    try:
        spark = SparkSession.builder \
            .appName("TestSpark") \
            .master("local[*]") \
            .getOrCreate()
        
        data = [("Alice", 34), ("Bob", 45), ("Charlie", 29)]
        columns = ["Name", "Age"]
        df = spark.createDataFrame(data, columns)
        
        df.show()
        
        df_filtered = df.filter(df.Age > 30)
        df_filtered.show()

        print("Conexión exitosa a Spark y prueba ejecutada con éxito.")
    except Exception as e:
        print(f"Error al conectar a Spark: {e}")

def test_mongodb():
    try:
        client = pymongo.MongoClient("mongodb://mongodb:27017/")
        client.admin.command('ping')
        print("Conexión exitosa a MongoDB")
    except ConnectionFailure as e:
        print(f"Error al conectar a MongoDB: {e}")

def test_postgres():
    try:
        conn = psycopg2.connect(
            dbname="mydb",
            user="admin",
            password="admin",
            host="postgres",
            port="5432"
        )
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        print("Conexión exitosa a PostgreSQL")
        cur.close()
        conn.close()
    except OperationalError as e:
        print(f"Error al conectar a PostgreSQL: {e}")

def test_redis():
    try:
        r = redis.Redis(host="redis", port=6379)
        r.set("test", "value")  # Prueba simple de escritura
        print("Conexión exitosa a Redis")
    except ConnectionError as e:
        print(f"Error al conectar a Redis: {e}")

if __name__ == "__main__":
    print("Probando los servicios...\n")
    test_spark()
    test_mongodb()
    test_postgres()
    test_redis()
