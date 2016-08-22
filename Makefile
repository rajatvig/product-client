NAME=ProductClient

RBENV=rbenv exec
BUNDLE=bundle exec
FASTLANE=$(BUNDLE) fastlane

DC=docker-compose

stop:
	$(DC) stop
	$(DC) down --rmi local --remove-orphans -v
	$(DC) rm --all -f -v

clean: stop

install:
	$(RBENV) $(BUNDLE) install
	$(RBENV) $(BUNDLE) pod install

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
