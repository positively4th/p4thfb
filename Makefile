.PHONY: \
	default \
	dev dev-start dev-stop dev-clone-p4thfb_import dev-clone-p4thfb_api dev-clone-p4thfb_app \
	p4thfb_import p4thfb_api p4thfb_app \
	docker docker-buid docker-import-shell docker-start docker-start docket-stop docker-remove \
	docker-postgres-start docker-postgres-start \
	clean clean-prune

default:
	docker-build

#dev
dev: dev-start

dev-start: dev-clone-p4thfb_import dev-clone-p4thfb_api dev-clone-p4thfb_app docker-postgres-start
	make -C p4thfb_api setup
	make -C p4thfb_import setup
	make -C p4thfb_api setup
	make -C p4thfb_app setup

dev-stop: docker-postgres-stop

dev-clone-p4thfb_import:
	(git clone https://github.com/positively4th/p4thfb_import.git || echo) \
	&& (cd p4thfb_import && git status)

dev-clone-p4thfb_api:
	(git clone https://github.com/positively4th/p4thfb_api.git || echo) \
	&& (cd p4thfb_api && git status)

dev-clone-p4thfb_app:
	(git clone https://github.com/positively4th/p4thfb_app.git || echo) \
	&& (cd p4thfb_app && git status)



#docker
docker-build: 
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

docker-remove: docker-stop
	docker compose rm

#docker-postgres
docker-postgres-start: 
	make -C p4thfb_api docker-postgres
	docker compose up -d postgres

docker-postgres-stop: 
	docker compose stop postgres
	docker compose rm postgres


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









