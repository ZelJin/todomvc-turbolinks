#!/bin/bash
# Taken from https://docs.docker.com/compose/startup-order/

set -e

export PGPASSWORD=$POSTGRES_PASSWORD
until psql -h $POSTGRES_HOST -U $POSTGRES_USER -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up!"
