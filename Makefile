#############################
# Docker machine states
#############################

## Start the project
up:
	docker-compose up -d

## Stop the project
stop:
	docker-compose stop

## Remove the project images, volumes and docker network
destroy:
	docker-compose down -v

## Restart all project containers
restart: stop up

## Display current state of the containers
state:
	docker-compose ps

## Rebuild all containers
rebuild: stop
	docker-compose pull
	docker-compose build --pull
	make up

## Show logs for all containers. 
## Use "make logs s=some-service" to specify a single service. 
logs:
	docker-compose logs -f --tail=50 $(s)

## Reloads a service with updated src
## Usage: make reload s=some-service
reload:
	docker exec -it code_$(s)_1 bash -c "cd /app && go build -o /service && chown 1000:1000 /service"
	docker stop code_$(s)_1
	docker commit code_$(s)_1 code_$(s)
	docker rm code_$(s)_1
	make up
