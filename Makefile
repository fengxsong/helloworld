.PHONY: deps
deps:
	sudo apt-get install -y uidmap fuse-overlayfs qemu-user-static

.PHONY: docker
docker:
	buildah manifest create helloworld
	buildah build -t fengxsong/helloworld:test --platform linux/amd64,linux/arm64 --manifest helloworld .
	buildah manifest push --all helloworld docker://docker.io/fengxsong/helloworld:test
