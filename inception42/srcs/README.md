*This project has been created as part of the 42 curriculum by kabu-zee.*

## Description

Inception is a system administration project that builds a small 
infrastructure using Docker Compose. It sets up three services — 
NGINX, WordPress with PHP-FPM, and MariaDB — each running in its 
own container, communicating over a private Docker network.

### Design Choices

#### Virtual Machines vs Docker
A VM virtualizes an entire operating system including the kernel,
making it heavy and slow to start. Docker containers share the host
kernel and only virtualize the application layer, making them 
lightweight and fast. However VMs provide stronger isolation.

#### Secrets vs Environment Variables
Environment variables are visible to all processes in a container
and can be accidentally logged or exposed. Docker secrets are 
mounted as files inside the container at `/run/secrets/`, making
them harder to leak and more secure for sensitive data like passwords.

#### Docker Network vs Host Network
Host network mode makes the container share the host's network 
directly, exposing all ports and removing isolation. Docker bridge
network creates a private internal network where containers 
communicate by service name, with only explicitly published ports
accessible from outside.

#### Docker Volumes vs Bind Mounts
Bind mounts depend on the host directory structure and are less
portable. Named volumes are managed by Docker, more portable, and
the subject requires them for persistent storage of WordPress files
and the database.

## Instructions

### Prerequisites
- Docker and Docker Compose installed
- Add to `/etc/hosts`: `127.0.0.1 kabu-zee.42.fr`

### Setup
1. Clone the repository
2. Create `srcs/.env` (see DEV_DOC.md for format)
3. Create `secrets/` files (see DEV_DOC.md for format)
4. Run `make`

### Commands
| Command | Description |
|---|---|
| `make` | Build and start all containers |
| `make down` | Stop and remove containers |
| `make clean` | Remove containers and images |
| `make fclean` | Full reset including volumes |
| `make re` | Full rebuild |
| `make logs` | Tail all container logs |

## Resources

- [Docker Documentation](https://docs.docker.com)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress WP-CLI](https://wp-cli.org/)
- [MariaDB Documentation](https://mariadb.com/kb/en/)
- [PHP-FPM Configuration](https://www.php.net/manual/en/install.fpm.configuration.php)

### AI Usage
Claude (Anthropic) was used to assist with:
- Dockerfile structure and best practices
- Shell script logic for database and WordPress initialization
- NGINX SSL configuration
- Documentation writing

All generated content was reviewed, tested, and understood before use.
