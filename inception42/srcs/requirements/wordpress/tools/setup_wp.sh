# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup_wp.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kabu-zee <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/08 11:29:55 by kabu-zee          #+#    #+#              #
#    Updated: 2026/06/08 11:30:04 by kabu-zee         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


set -e


DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/credentials)
WP_USER_PASSWORD=$(cat /run/secrets/credentials2)


mkdir -p /run/php


echo "Waiting for MariaDB..."
while ! mysqladmin ping -h mariadb -u ${MYSQL_USER} -p${DB_PASSWORD} --silent 2>/dev/null; do
    sleep 1
done
echo "MariaDB is ready!"


if [ ! -f "/var/www/html/wp-config.php" ]; then

    # Download WordPress core
    wp core download \
        --path=/var/www/html \
        --allow-root

    # Create wp-config.php
    wp config create \
        --path=/var/www/html \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=mariadb \
        --allow-root

    # Install WordPress
    wp core install \
        --path=/var/www/html \
        --url=https://${DOMAIN_NAME} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    # Create second user
    wp user create \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --role=editor \
        --user_pass=${WP_USER_PASSWORD} \
        --path=/var/www/html \
        --allow-root

    # Fix permissions
    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;

    echo "WordPress installed successfully!"
fi

# Start PHP-FPM in foreground (PID 1)
exec php-fpm7.4 -F
