ifdef GITHUB_ACCOUNT
	ACCOUNT := $(GITHUB_ACCOUNT)
else
	ACCOUNT := $(USER)
endif
REPOSITORY := $(subst docker-,,$(shell basename $(shell dirname $(realpath  $(lastword $(MAKEFILE_LIST))))))
CONTAINER := $(REPOSITORY)
CURRENT_DIR := $(shell pwd)

all: help

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build [OPTIONS]"
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

start:
	@echo "Starting '$(CONTAINER)' container..."
	@docker run --detach \
		--name="$(CONTAINER)" \
		--hostname="$(CONTAINER)" \
		--env="DB_NAME=test" \
		--env="DB_USER=test" \
		--env="DB_PASS=test" \
		--env="APT_PROXY=$(APT_PROXY)" \
		--volume=$(CURRENT_DIR)/.data:/var/lib/postgresql \
		--publish=5432:5432 \
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
