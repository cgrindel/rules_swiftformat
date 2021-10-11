#!/usr/bin/env bash

set -uo pipefail

cd "${BUILD_WORKSPACE_DIRECTORY}"

bazel_query="kind(swiftformat_update, //...)"
update_targets=( $(bazel query "${bazel_query}" | sort) )

for target in "${update_targets[@]}" ; do
  bazel run "${target}"
done
