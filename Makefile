NAME = clairvy/serverspec
DOCKER_HOST = $(shell boot2docker up 2>&1 | awk -F= '/export/{print $$2}')
DOCKER = docker --host=$(DOCKER_HOST)
DOCKER_RUN_CMD = /bin/bash

PROFILE = home/.bash_profile
DOCKER_INTERNAL_HOST = $(shell ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2022 -i /Users/s-nag/.ssh/id_boot2docker docker@localhost ip addr show dev docker0 2> /dev/null|awk '/inet /{print $$2}'|sed -e 's|/.*||')
DOCKER_INTERNAL_PORT = $(shell boot2docker config 2> /dev/null|awk '/DockerPort /{print $$3}')

default: build

build: profile
	$(DOCKER) build -t $(NAME) .

run:
	$(DOCKER) run -i -t --rm $(NAME) $(DOCKER_RUN_CMD)

ps:
	$(DOCKER) ps -a

images:
	$(DOCKER) images

profile: $(PROFILE)
$(PROFILE):
	mkdir -p `dirname $(PROFILE)`
	echo 'DOCKER_HOST=tcp://$(DOCKER_INTERNAL_HOST):$(DOCKER_INTERNAL_PORT); export DOCKER_HOST' > $(PROFILE)

clean:
	$(RM) $(RMF) *~ */*~
