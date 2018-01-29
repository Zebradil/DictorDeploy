#!/bin/sh -e

RETRIES=10
until PGPASSWORD=${POSTGRES_PASSWORD} \
	pg_isready \
	-h db \
	-p 5432 \
	-d ${POSTGRES_DB} \
	-U ${POSTGRES_USER}; do
	if test ${RETRIES} -gt 0; then
		let RETRIES-=1
		echo "${RETRIES} Waiting for database..."
		sleep 3
	else
		exit 1
	fi
done

cd /var/www/api

composer install

./bin/console doctrine:database:create --if-not-exists --no-interaction --verbose
./bin/console doctrine:schema:update --complete --force --no-interaction --verbose

#ln -sfn /dev/stdout var/logs/dev.log
mkdir -p var/cache var/logs var/sessions
chown www-data:www-data -R var/cache var/logs var/sessions

php-fpm
