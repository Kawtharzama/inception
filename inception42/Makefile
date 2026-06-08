# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kabu-zee <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/07 15:20:58 by kabu-zee          #+#    #+#              #
#    Updated: 2026/06/07 15:21:13 by kabu-zee         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE	= srcs/docker-compose.yml
DATA_DIR	= /home/kabu-zee/data

all:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb
	docker compose -f $(COMPOSE_FILE) up -d --build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

stop:
	docker compose -f $(COMPOSE_FILE) stop

start:
	docker compose -f $(COMPOSE_FILE) start

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

clean: down
	docker system prune -af

fclean: clean
	docker run --rm -v /home/kabu-zee/data/mariadb:/mariadb -v /home/kabu-zee/data/wordpress:/wordpress debian:bullseye rm -rf /mariadb/* /wordpress/*
	docker volume prune -f

re: fclean all

.PHONY: all up down stop start logs clean fclean re
