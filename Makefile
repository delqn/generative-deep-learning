#!make

SHELL:=bash

.PHONY: prereqs
prereqs:
	sudo apt-get install python3-pip
	pip3 install virtualenv virtualenvwrapper
	virtualenv generative
	source generative/bin/activate
	pip3 install -r requirements.pip3
