.PHONY: install

install: install-python install-hooks install-node

install-node:
	npm ci

install-python:
	poetry install

install-hooks: install-python
	poetry run pre-commit install --install-hooks --overwrite

test:

lint: lint-githubactions

lint-githubactions:
	actionlint

check-licenses:
	npm run check-licenses

deep-clean:
	find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +
