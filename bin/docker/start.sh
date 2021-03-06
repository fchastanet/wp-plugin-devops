#!/bin/sh

echo "Starting webserver..."

docker-compose -f ${PLUGIN_PATH}/docker-compose.yml up -d

echo "Initializing project..." >&2

echo "Waiting for Database Container..."
${VENDOR_BIN_PATH}/docker/waitfor localhost 3306 # Does not take effect right now

echo "Database ready."

echo "Waiting for Filesystem..."
while [ ! -e ${PLUGIN_PATH}/wordpress/wp-config.php ]; do
    sleep 1
done

sleep 3

echo "File system ready."

docker exec ${WP_CONTAINER_NAME} wp plugin update --all --path=/var/www/html
docker exec ${WP_CONTAINER_NAME} wp theme update --all --path=/var/www/html

docker exec ${WP_CONTAINER_NAME} mkdir -p ${REMOTE_PLUGIN_PATH}
${VENDOR_BIN_PATH}/docker/sync.sh
docker exec ${WP_CONTAINER_NAME} wp plugin activate ${PLUGIN_SLUG} --path=/var/www/html

# Custom user scripts
if [ -f "${PLUGIN_PATH}/project.sh" ]; then
    echo "Starting project scripts..."
    ${PLUGIN_PATH}/project.sh
fi

echo "Finished starting webserver!"