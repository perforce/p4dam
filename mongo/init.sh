#!/bin/bash

set -e

# Make sure required env vars exist
: "${HTH_DB_NAME:?Need to set HTH_DB_NAME}"
: "${HTH_DB_USERNAME:?Need to set HTH_DB_USERNAME}"
: "${HTH_DB_PASSWORD:?Need to set HTH_DB_PASSWORD}"

mongosh -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase "admin" <<EOF
use $HTH_DB_NAME
db.createUser({
  user: "$HTH_DB_USERNAME",
  pwd: "$HTH_DB_PASSWORD",
  roles: [{ role: "dbOwner", db: "$HTH_DB_NAME" }]
})
EOF