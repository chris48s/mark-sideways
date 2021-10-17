SHELL := /bin/bash
.PHONY: help format install lint test release

help:
	@grep '^\.PHONY' Makefile | cut -d' ' -f2- | tr ' ' '\n'

format:
	poetry run isort --profile black .
	poetry run black .

install:
	poetry install

lint:
	poetry run isort --profile black -c --diff .
	poetry run black --check .
	poetry run flake8 .

test:
	poetry run mark down README.md
	poetry run mark up README.md
	poetry run mark sideways README.md
	echo "TODO: write some proper tests"

release:
	# usage: `make release version=0.0.0`
	make test
	@echo ""
	make lint
	@echo ""
	./release.sh "$(version)"
