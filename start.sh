#!/bin/sh

(
    cd "$(dirname "$0")"

    echo "Running migrations..."
    mlflow db upgrade $DATABASE_URI

    # db upgrade only works without error strictly after the server has run at least once
    # So we exit on failure only after we run db upgrade
    set -e

    echo "Starting mlflow server and proxy..."
    parallel --will-cite --line-buffer --jobs 2 --halt now,done=1 ::: \
        "mlflow server --host 0.0.0.0 --port 5000 --serve-artifacts --artifacts-destination s3://${ARTIFACT_BUCKET_NAME} --backend-store-uri ${DATABASE_URI} --gunicorn-opts '--log-level debug'" \
        "PROXY_PORT=${PROXY_PORT} UPSTREAM_ROOT='http://0.0.0.0:5000' python3 -m proxy"
)
