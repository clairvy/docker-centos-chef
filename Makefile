NAME = clairvy/use_bundler
DOCKER_HOST = $(shell boot2docker up 2>&1 | awk -F= '/export/{print $$2}')
DOCKER = docker --host=$(DOCKER_HOST)
DOCKER_RUN_CMD = /bin/bash

default: build

build:
	$(DOCKER) build -t $(NAME) .

run:
	$(DOCKER) run -i -t --rm $(NAME) $(DOCKER_RUN_CMD)

ps:
	$(DOCKER) ps -a

images:
	$(DOCKER) images

clean:
	$(RM) $(RMF) *~ */*~
