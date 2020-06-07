BUNDLE_IDENTIFIER:=jp.ca21engineer.SubsClient
PROJECT_NAME:=SubsClient

.PHONY: init
init:
	./scripts/bootstrap.sh $(PROJECT_NAME) $(BUNDLE_IDENTIFIER)

.PHONY: xcodegen
xcodegen:
	./scripts/xcodegen.sh

export PATH += :$(PWD)/bin
GRPC_OUT:=./Repository/Sources/Generated
.PHONY: proto
proto: proto_clean
	mkdir -p $(GRPC_OUT)
	protoc ./Subs-server/protobuf/subscription.proto \
	    --proto_path ./Subs-server/protobuf \
	    --grpc-swift_out Client=true,Server=false,Visibility=Public:$(GRPC_OUT) \
	    --swift_out Visibility=Public:$(GRPC_OUT) 
	./scripts/xcodegen.sh

proto_clean:
	find . -type d | grep Generated | xargs rm -r
