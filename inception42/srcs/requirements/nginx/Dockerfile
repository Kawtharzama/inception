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
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/sites-available/default
COPY tools/generate_ssl.sh /generate_ssl.sh

RUN chmod +x /generate_ssl.sh \
    && /generate_ssl.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
