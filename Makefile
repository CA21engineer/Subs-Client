BUNDLE_IDENTIFIER:=jp.ca21engineer.SubsClient
PROJECT_NAME:=SubsClient

.PHONY: init
init:
	./scripts/bootstrap.sh $(PROJECT_NAME) $(BUNDLE_IDENTIFIER)

.PHONY: xcodegen
xcodegen:
	./scripts/xcodegen.sh

export PATH += :$(PWD)/bin
GRPC_OUT:=./SubsClient/Sources/Generated
.PHONY: proto
proto:
	mkdir -p $(GRPC_OUT)
	protoc ./Subs-server/protobuf/subscription.proto \
	    --proto_path ./Subs-server/protobuf \
	    --grpc-swift_out $(GRPC_OUT) \
	    --swift_out $(GRPC_OUT) 
	./scripts/xcodegen.sh
