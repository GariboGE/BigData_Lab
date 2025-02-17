#!/bin/bash

# Probando PostgreSQL
echo "🔎 Probando PostgreSQL..."
pg_isready -h localhost -p 5432
if [ $? -eq 0 ]; then
  echo "✅ PostgreSQL está disponible."
else
  echo "❌ No se puede conectar a PostgreSQL."
fi

# Probando MongoDB
echo "🔎 Probando MongoDB..."
if command -v mongosh &> /dev/null; then
  mongo_client="mongosh"
else
  mongo_client="mongo"
fi

$mongo_client --host localhost --port 27017 --eval 'db.runCommand({ping: 1})' > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "✅ MongoDB está disponible."
else
  echo "❌ No se puede conectar a MongoDB."
fi

# Probando Redis
echo "🔎 Probando Redis..."
REDIS_OUTPUT=$(redis-cli -h localhost ping 2>/dev/null)
if [ "$REDIS_OUTPUT" == "PONG" ]; then
  echo "✅ Redis está disponible."
else
  echo "❌ No se puede conectar a Redis."
fi
