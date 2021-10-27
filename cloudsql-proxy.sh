#!/usr/bin/env bash

export PROJECT_ID=dev-project
export POSTGRESQL_CONNECTION_NAME=dev-project:us-central1:pg-sql-db
export DB_PORT=5432

if [ "$(uname)" == "Darwin" ]; then
  curl -o cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
fi

chmod +x cloud_sql_proxy

gcloud auth login
gcloud config set project ${PROJECT_ID}

./cloud_sql_proxy -instances=${POSTGRESQL_CONNECTION_NAME}=tcp:${DB_PORT}
