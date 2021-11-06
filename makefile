# Makefile

BUILD_DIR := Dockerfile
REGISTRY := ghcr.io
GHCR_USERNAME := yqlbu
IMAGE_NAME := hikariai-web
IMAGE_TAG := latest
DOMAIN_NAME := hikariai.net
ENV := latest
SERVER_IP := 10.10.10.50

# Modify tagging mechanism
ifeq ($(ENV), dev)
	export IMAGE_TAG=dev
else ifeq ($(ENV), prod)
	export IMAGE_TAG=prod
else
	export IMAGE_TAG=latest
endif

# List of commands
build:
	@docker build -f $(BUILD_DIR) \
		-t $(REGISTRY)/$(GHCR_USERNAME)/$(IMAGE_NAME):$(IMAGE_TAG) \
		.

ghcr-login:
	@echo $(GHCR_TOKEN) | docker login ghcr.io -u $(GHCR_USERNAME) --password-stdin

push: ghcr-login
	@docker push ghcr.io/$(GHCR_USERNAME)/$(IMAGE_NAME):$(IMAGE_TAG)

local-run:
	@docker run -it --rm --name hugo-web -p 80:80 $(DOCKERHUB_USERNAME)/$(IMAGE_NAME):$(IMAGE_TAG)
