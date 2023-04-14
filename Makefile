.PHONY: install

default: install

install:
	go mod tidy
	go install .

dockerbuild:
	docker build -t grp:latest .
