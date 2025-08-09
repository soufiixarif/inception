all:
	mkdir -p ${PWD}/data/wordpress
	mkdir -p ${PWD}/data/mariadb
	docker compose -f srcs/docker-compose.yml up --build

clean:
	docker compose -f srcs/docker-compose.yml down -v

fclean: clean
	docker system prune -af --volumes
	sudo rm -rf ${PWD}/data

re: fclean all