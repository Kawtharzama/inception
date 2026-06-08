# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    generate_ssl.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kabu-zee <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/08 11:29:55 by kabu-zee          #+#    #+#              #
#    Updated: 2026/06/08 11:30:04 by kabu-zee         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #



set -e

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=JO/ST=Amman/L=Amman/O=42/OU=inception/CN=kabu-zee.42.fr"
