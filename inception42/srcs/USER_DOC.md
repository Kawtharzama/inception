# User Documentation — Inception

## What services does this stack provide?

| Service | Description |
|---|---|
| NGINX | Web server, entry point via port 443 (HTTPS) |
| WordPress | Content management system |
| MariaDB | Database storing all WordPress data |

## Start and stop the project

```bash
# Start
make

# Stop
make down

# Full reset
make fclean && make
```

## Access the website

- **Website:** https://kabu-zee.42.fr
- **Admin panel:** https://kabu-zee.42.fr/wp-admin

> Accept the browser SSL warning — the certificate is self-signed.

## Credentials

All credentials are stored in:
- `secrets/db_password.txt` — database user password
- `secrets/db_root_password.txt` — database root password
- `secrets/credentials.txt` — WordPress admin password
- `secrets/credentials2.txt` — WordPress editor password
- `srcs/.env` — usernames, emails, domain

## Check services are running

```bash
# See all running containers
docker ps

# Check logs
make logs

# Check specific service
docker logs mariadb
docker logs wordpress
docker logs nginx
```
