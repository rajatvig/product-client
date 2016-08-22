NAME=ProductClient

FASTLANE=bundle exec fastlane

DC=docker-compose

stop:
	$(DC) stop
	$(DC) down --rmi local --remove-orphans -v
	$(DC) rm --all -f -v

clean: stop

install:
	bundle install
	pod install

lint:
	$(FASTLANE) lint

test_local: stop
	$(DC) up -d
	$(FASTLANE) test_local

test:
	$(FASTLANE) test

contract_tests: stop
	$(DC) up -d
	$(FASTLANE) contract_tests
	$(DC) stop
