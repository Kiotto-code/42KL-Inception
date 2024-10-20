
DB_DATA= /home/yichan/data/mysql
WP_DATA= /home/yichan/data/wordpress
DOCKER_COMPOSE= docker compose
DOCKER_COMPOSE_FILE= ./srcs/docker-compose.yml

all: build-up

build-up:
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker-compose.yml up --build

kill:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill
down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	rm -r /home/yichan/data/mysql
	rm -r /home/yichan/data/wordpress
	docker system prune -a -f

restart: clean build-up

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