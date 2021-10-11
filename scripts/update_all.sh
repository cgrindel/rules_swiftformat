#!/usr/bin/env bash

# This script will query for all of the swiftformat_update targets and execute
# it each one.

set -uo pipefail

cd "${BUILD_WORKSPACE_DIRECTORY}"

bazel_query="kind(swiftformat_update, //...)"
update_targets=( $(bazel query "${bazel_query}" | sort) )

for target in "${update_targets[@]}" ; do
  bazel run "${target}"
done
