all: up

up:
	docker compose -f ./srcs/docker-compose.yml up -d

build-up:
	docker compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker compose -f ./srcs/docker-compose.yml down

rebuild: down build-up

restart: down up

prune: clean
	@docker system prune -a --volumes -f

ssl:
	./srcs/requirements/tools/ssl.sh

stop:
	docker compose -f ./srcs/docker-compose.yml stop

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

restart:	down all

rebuild:	clean all

re:		prune all 

# reset:		fclean all

# docker-compose up: This command does the work of the docker-compose build and docker-compose run commands. I
# docker-compose down: This command is similar to the docker system prune command. However, in Compose, it stops all the services and cleans up the containers, networks, and images.
# docker-compose logs: This command is used to view the logs of the services running in the docker-compose.yml file.