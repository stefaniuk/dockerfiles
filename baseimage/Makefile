ifdef GITHUB_ACCOUNT
	ACCOUNT := $(GITHUB_ACCOUNT)
else
	ACCOUNT := $(USER)
endif
REPOSITORY := $(subst docker-,,$(shell basename $(shell dirname $(realpath  $(lastword $(MAKEFILE_LIST))))))
CONTAINER := $(REPOSITORY)
DATE := $(shell date +%Y%m%d)

all: help

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build [OPTIONS]"
	@echo "    make tag [OPTIONS]"
	@echo "    make start [OPTIONS]"
	@echo "    make log"
	@echo "    make exec"
	@echo "    make stop"
	@echo "    make purge"
	@echo

build:
	@echo "Building '$(CONTAINER)' container..."
	@./scripts/build.sh \
		$(ACCOUNT)/$(REPOSITORY) \
		$(APT_PROXY)

tag: build
	@echo "Tagging '$(CONTAINER)' container..."
	@docker tag -f $(ACCOUNT)/$(REPOSITORY) $(ACCOUNT)/$(REPOSITORY):$(DATE)
	@docker push $(ACCOUNT)/$(REPOSITORY):$(DATE)

start:
	@echo "Starting '$(CONTAINER)' container..."
	@docker run --detach \
		--name="$(CONTAINER)" \
		--hostname="$(CONTAINER)" \
		--env="APT_PROXY=$(APT_PROXY)" \
		$(ACCOUNT)/$(REPOSITORY) > /dev/null

log:
	@docker logs $(CONTAINER)

exec:
	@docker exec -it $(CONTAINER) /bin/bash --login

stop:
	@echo "Stopping '$(CONTAINER)' container..."
	@docker stop $(CONTAINER) > /dev/null

purge: stop
	@echo "Removing '$(CONTAINER)' container..."
	@docker rm $(CONTAINER) > /dev/null
