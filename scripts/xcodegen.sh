#!/bin/bash

set -eu

echo "Generate xcodeproj file by XcodeGen...."
mint run xcodegen generate --use-cache
bundle exec pod install
