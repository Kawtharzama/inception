# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kabu-zee <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/08 11:28:48 by kabu-zee          #+#    #+#              #
#    Updated: 2026/06/08 11:28:54 by kabu-zee         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf
COPY tools/init_db.sh /init_db.sh

RUN chmod +x /init_db.sh

EXPOSE 3306

ENTRYPOINT ["/init_db.sh"]
