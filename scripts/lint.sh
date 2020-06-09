#!/bin/sh

git status --porcelain | grep -e '^[ ?][^D]\s.*\.swift$' | awk -F' ' '{print $2}' | while read filename; do
  mint run realm/swiftlint swiftlint --path "$SRCROOT/$filename"
done
