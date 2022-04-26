#!/bin/bash
set -o errexit
set -o errtrace
set -o nounset

source .env
docker compose run --rm composer install
docker compose run --rm \
    --env WP_ADMIN_USER=${WP_ADMIN_USER} \
    --env WP_ADMIN_PASS=${WP_ADMIN_PASS} \
    --env WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL} \
    wordpress-cli content-import/configure-wordpress.sh
