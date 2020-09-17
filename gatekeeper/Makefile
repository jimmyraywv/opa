
.DEFAULT_GOAL := up

.PHONY:	up down wipe-k8s test

wipe-k8s:
	./wipe-k8s.sh

up:
	./up.sh

down:
	./down.sh

test:
	tests/tests.sh

