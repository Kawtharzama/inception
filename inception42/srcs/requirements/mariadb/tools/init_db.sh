# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init_db.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kabu-zee <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/08 11:29:55 by kabu-zee          #+#    #+#              #
#    Updated: 2026/06/08 11:30:04 by kabu-zee         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)


mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql


if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # Start MariaDB temporarily for setup
    mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;

-- Secure root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

-- Remove anonymous users and test database
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;

-- Create WordPress database
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Create WordPress user
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF
fi


exec mysqld --user=mysql
