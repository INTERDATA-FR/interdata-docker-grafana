include params

build: build-grafana

build-grafana:
	@echo "======================================================================"
	@echo "  ____  _    _ _____ _      _____  "
	@echo " |  _ \| |  | |_   _| |    |  __ \ "
	@echo " | |_) | |  | | | | | |    | |  | |"
	@echo " |  _ <| |  | | | | | |    | |  | |"
	@echo " | |_) | |__| |_| |_| |____| |__| |"
	@echo " |____/ \____/|_____|______|_____/ "
	@echo "                                   "
	@echo " Docker image - $(GRAFANA_IMAGE_NAME):$(GRAFANA_IMAGE_TAG)"
	@echo "======================================================================"
	docker build \
		--build-arg UBUNTU_IMAGE=$(UBUNTU_IMAGE) \
		--build-arg GRAFANA_IMAGE=$(GRAFANA_IMAGE_VERSION) \
		-t $(GRAFANA_IMAGE_NAME):$(GRAFANA_IMAGE_TAG) \
		.

clean-all:
	./scripts/docker-clean-all.sh

cli:
	@echo "======================================================================"
	@echo "   _____ _      _____ "
	@echo "  / ____| |    |_   _|"
	@echo " | |    | |      | |  "
	@echo " | |    | |      | |  "
	@echo " | |____| |____ _| |_ "
	@echo "  \_____|______|_____|"
	@echo "                      "
	@echo " Docker cli - $(GRAFANA_CONTAINER_NAME)"
	@echo "======================================================================"
	docker exec -i -t $(GRAFANA_CONTAINER_NAME) /bin/bash

destroy:
	@echo "============================================================"
	@echo "DOCKER DESTROY - $(DOCKER_FILE)"
	@echo "============================================================"
	docker-compose -f $(DOCKER_FILE) down
	rm -Rf ./data/*
	./scripts/docker-clean-all.sh

rebuild: destroy clean-all build start

restart:
	@echo "============================================================"
	@echo "DOCKER RESTART - $(DOCKER_FILE)"
	@echo "============================================================"
	docker-compose -f $(DOCKER_FILE) restart

start:
	@echo "============================================================"
	@echo "DOCKER START - $(DOCKER_FILE)"
	@echo "============================================================"
	docker-compose -f $(DOCKER_FILE) up -d

stop:
	@echo "============================================================"
	@echo "DOCKER STOP - $(DOCKER_FILE)"
	@echo "============================================================"
	docker-compose -f $(DOCKER_FILE) stop
