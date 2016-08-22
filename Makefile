NAME=ProductClient

GEM=rbenv exec gem
BUNDLE=rbenv exec bundle
POD=rbenv exec pod
FASTLANE=rbenv exec bundle exec fastlane

DC=docker-compose

POD_OPTIONS=--verbose --allow-warnings

stop:
	$(DC) stop
	$(DC) down --rmi local --remove-orphans -v
	$(DC) rm --all -f -v

clean: stop

install:
	$(BUNDLE) install
	$(POD) install

test_local: stop
	$(DC) up -d
	$(FASTLANE) test_local

test:
	$(FASTLANE) test

lint:
	$(FASTLANE) lint

contract_tests: stop
	$(DC) up -d
	$(FASTLANE) contract_tests

publish_contract:
	$(DC) run pactbroker-client

lint_podspec_local:
	$(POD) lib lint $(POD_OPTIONS) $(NAME).podspec

lint_podspec:
	$(POD) spec lint $(POD_OPTIONS) $(NAME).podspec

push:
	$(POD) repo push $(POD_OPTIONS) $(NAME).podspec
