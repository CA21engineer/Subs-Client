BUNDLE_IDENTIFIER:=jp.ca21engineer.SubsClient
PROJECT_NAME:=SubsClient

.PHONY: init
init:
	./scripts/bootstrap.sh $(PROJECT_NAME) $(BUNDLE_IDENTIFIER)

.PHONY: xcodegen
xcodegen:
	./scripts/xcodegen.sh
