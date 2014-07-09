NAME = clairvy/aaa
DOCKER_HOST = $(shell boot2docker up 2>&1 | awk -F= '/export/{print $$2}')
DOCKER = docker --host=$(DOCKER_HOST)

default: build

build:
	$(DOCKER) build -t $(NAME) .
