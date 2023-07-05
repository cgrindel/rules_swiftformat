"""Deprecated. Legacy external dependencies for rules_swiftformat."""

# NOTE: This file is deprecated and will be removed in a future release. Please use
# //swifttidy:deps.bzl intead.

load("//swifttidy:deps.bzl", "swifttidy_rules_dependencies")

swiftformat_rules_dependencies = swifttidy_rules_dependencies
