.PHONY: install

install:
	npm ci

test:

lint: lint-githubactions

lint-githubactions:
	actionlint

check-licenses:
	npm run check-licenses

deep-clean:
	find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +
