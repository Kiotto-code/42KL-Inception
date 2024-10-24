DOCKER_COMPOSE=docker compose

DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

.PHONY: kill build down clean restart

build:
	mkdir -p /home/yichan/data/mysql
	mkdir -p /home/yichan/data/wordpress
	@$(DOCKER_COMPOSE)  -f $(DOCKER_COMPOSE_FILE) up --build -d

kill:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill

down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

pre-clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

fclean: clean
	rm -r /home/yichan/data/mysql || true
	rm -r /home/yichan/data/wordpress || true
	docker system prune -a -f

mrdb:
	@docker exec -it mariadb /bin/bash

ngx:
	@docker exec -it nginx /bin/bash

wp:
	@docker exec -it wordpress /bin/bash

restart: clean build

fclean-restart: fclean restart