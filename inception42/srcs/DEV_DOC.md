# Developer Documentation — Inception

## Prerequisites

- Docker >= 20.10
- Docker Compose >= 2.0
- Debian/Ubuntu based system

## Environment setup from scratch

### 1. Clone the repository
```bash
git clone <your_repo_url>
cd inception
```

### 2. Add domain to /etc/hosts
```bash
sudo vim /etc/hosts
# Add this line:
127.0.0.1 kabu-zee.42.fr
```

### 3. Create srcs/.env
```bash
DOMAIN_NAME=kabu-zee.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=kabu_db_user
WP_ADMIN_USER=kabu_chief
WP_ADMIN_EMAIL=kabu-zee@42.fr
WP_USER=kabu_editor
WP_USER_EMAIL=editor@42.fr
WP_TITLE=Kabu's Inception
```

### 4. Create secrets files
```bash
mkdir -p secrets
echo "your_db_password"      > secrets/db_password.txt
echo "your_root_password"    > secrets/db_root_password.txt
echo "your_admin_password"   > secrets/credentials.txt
echo "your_editor_password"  > secrets/credentials2.txt
```

## Build and launch

```bash
make
```

This will:
1. Create `/home/kabu-zee/data/wordpress` and `/home/kabu-zee/data/mariadb`
2. Build all Docker images
3. Start all containers

## Useful commands

```bash
# Rebuild a single service
docker compose -f srcs/docker-compose.yml build mariadb

# Enter a container
docker exec -it mariadb bash
docker exec -it wordpress bash
docker exec -it nginx bash

# Check volumes
docker volume ls

# Check network
docker network ls
```

## Data persistence

| Data | Location on host |
|---|---|
| WordPress files | `/home/kabu-zee/data/wordpress` |
| MariaDB database | `/home/kabu-zee/data/mariadb` |

Data survives container restarts. Only `make fclean` wipes it.
