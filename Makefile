.PHONY: \
	default \
	dev dev-start dev-stop \
	p4thfb_import-clone p4thfb_api-clone p4thfb_app-clone \
	p4thfb_import p4thfb_api p4thfb_app \
	docker docker-buid docker-import-shell docker-start docker-start docket-stop docker-remove \
	docker-postgres-start docker-postgres-start \
	clean clean-prune

default:
	docker-build


#dev
dev: dev-start

dev-start: p4thfb_import-clone p4thfb_api-clone p4thfb_app-clone docker-postgres-start
	make -C p4thfb_api setup
	make -C p4thfb_import setup
	make -C p4thfb_api setup
	make -C p4thfb_app setup

dev-stop: docker-postgres-stop


#docker
docker-build: p4thfb_import-clone p4thfb_app-clone p4thfb_api-clone 
	make -C p4thfb_api docker-postgres
	make -C p4thfb_import docker-import
	make -C p4thfb_api docker-api
	make -C p4thfb_app docker-app
	docker compose build 

docker-import-shell:
	docker attach p4thfb-import

docker-app-shell:
	docker attach p4thfb-app-1

docker-start: docker-build
	docker compose up

docker-stop: 
	docker compose down
	docker compose rm

docker-remove: docker-stop
	docker compose rm


#docker-postgres
docker-postgres-start:
	make -C p4thfb_api docker-postgres
	docker compose up -d postgres

docker-postgres-stop: 
	docker compose stop postgres
	docker compose rm postgres

#docker-grafana
docker-grafana-build: 
	docker compose build --progress=plain grafana

docker-grafana-start: docker-grafana-build 
	docker compose up grafana

docker-grafana-stop: 
	docker compose stop grafana
	docker compose rm grafana


#p4thfb
p4thfb_import-clone:
	(git clone https://github.com/positively4th/p4thfb_import.git || echo) \
	&& (cd p4thfb_import && git status)

#p4thfb_api
p4thfb_api-clone:
	(git clone https://github.com/positively4th/p4thfb_api.git || echo) \
	&& (cd p4thfb_api && git status)

p4thfb_app-clone:
	(git clone https://github.com/positively4th/p4thfb_app.git || echo) \
	&& (cd p4thfb_app && git status)


p4thfb_import: 
#	(git clone https://github.com/positively4th/p4thfb_import.git || echo) \
#	&& (cd p4thfb_import && git pull) \
#	&&
	make -C p4thfb_import default

p4thfb_api: 
#	(git clone https://github.com/positively4th/p4thfb_api.git || echo) \
#	&& (cd p4thfb_api && git pull) \
#	&&
	make -C p4thfb_api default

p4thfb_app: 
#	(git clone https://github.com/positively4th/p4thfb_app.git || echo) \
#	&& (cd p4thfb_app && git pull) \
#	&&
	make -C p4thfb_app

clean: 
	make docker-stop || echo
	make -C p4thfb_app clean
	make -C p4thfb_api clean
	make -C p4thfb_import clean

clean-prune: clean
	docker system prune -a -f
	docker builder prune -a -f
	docker network prune -f









