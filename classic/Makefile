.DEFAULT_GOAL := up

.PHONY:	up down clean test

clean:
	./clean-local-config.sh 2>&1
	./clean-local-secrets.sh 2>&1

down:
	./down.sh 2>&1

up:
	./up.sh 2>&1

test:
	tests/tests.sh 2>&1

