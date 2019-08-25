#!make

SHELL:=bash

.PHONY: prereqs
prereqs:
	sudo apt-get update -yq
	sudo apt-get upgrade -yq
	sudo apt-get -yq install python3-pip
	pip3 install virtualenv virtualenvwrapper
	virtualenv generative
	source generative/bin/activate
	pip3 install -r requirements.pip3

.PHONY: run
run:
	python3 run.py

.PHONY: train-sequential
train-sequential:
	python3 -c 'from pupil import get_model_sequential, compile, train, save, show; m=get_model_sequential(); compile(m); train(m); save(m)'

.PHONY: train
train:
	python3 -c 'from pupil import get_model, compile, train, save, show; m=get_model(); compile(m); train(m); save(m)'

# Arguably this should be moved in Cloud-init
.PHONY: azure-bootstrap
azure-bootstrap:
	./scripts/azure/bootstrap.sh

.PHONY: azure-train
azure-train:
	./scripts/azure/train.sh

.PHONY: azure-deallocate
azure-deallocate:
	./scripts/azure/deallocate.sh

.PHONY: azure-shell
azure-shell:
	./scripts/azure/shell.sh

.PHONY: azure-status
azure-status:
	./scripts/azure/status.sh

.PHONY: clean
clean:
	$(shell find . -name '*~' -delete)
	$(shell find . -name '*\#*' -delete)
