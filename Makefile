
#VOLUME
DB_PATH=/home/yichan/data/mariadn
WP_PATH=/home/yichan/data/wordpress

all: up

up:
	@mkdir -p $(WP_DATA) || true
	@mkdir -p $(DB_DATA) || true
	docker compose -f ./srcs/docker-compose.yml up -d

build-up:
	@mkdir -p $(WP_DATA) || true
	@mkdir -p $(DB_DATA) || true
	docker compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker compose -f ./srcs/docker-compose.yml down

# rebuild: down build-up

# restart: down up

prune: clean
	@docker system prune -a --volumes -f

# ssl:
# 	./srcs/requirements/tools/ssl.sh

stop:
	docker compose -f ./srcs/docker-compose.yml stop

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

restart:	down up

rebuild:	down prune build-up

re:		prune build-up

mrdb:
	@docker exec -it mariadb /bin/bash

ngx:
	@docker exec -it nginx /bin/bash

wp:
	@docker exec -it wordpress /bin/bash


# reset:		fclean all

# docker-compose up: This command does the work of the docker-compose build and docker-compose run commands. I
# docker-compose down: This command is similar to the docker system prune command. However, in Compose, it stops all the services and cleans up the containers, networks, and images.
# docker-compose logs: This command is used to view the logs of the services running in the docker-compose.yml file.