.PHONY: install

install:
	npm ci

check-licenses:
	npm run check-licenses

deep-clean:
	find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +
