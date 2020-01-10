all: build_app build_go

build_app:
	docker build --pull -t stsg/baseimage:app-latest base.alpine -f base.alpine/Dockerfile

build_go:
	docker build --pull -t stsg/baseimage:buildgo-latest build.go -f build.go/Dockerfile


.PHONY: all
