#!make

SHELL:=bash

.PHONY: prereqs
prereqs:
	sudo apt-get install python3-pip
	pip3 install virtualenv virtualenvwrapper
	virtualenv generative
	source generative/bin/activate
	pip3 install -r requirements.pip3


.PHONY: run
run:
	python3 run.py

.PHONY: train-sequential
train-sequential:
	python3 -c 'from gedelearn import get_model_sequential, compile, train, save, show; m=get_model_sequential(); compile(m); train(m); save(m)'

.PHONY: train
train:
	python3 -c 'from gedelearn import get_model, compile, train, save, show; m=get_model(); compile(m); train(m); save(m)'
