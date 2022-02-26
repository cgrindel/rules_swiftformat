"""Deprecated. Public API for rules_swiftformat."""

# NOTE: This file is deprecated and will be removed in a future release. Please use
# //swiftformat:defs.bzl intead.

load(
    "//swiftformat:defs.bzl",
    _src_utils = "src_utils",
    _swiftformat_binary = "swiftformat_binary",
    _swiftformat_format = "swiftformat_format",
    _swiftformat_library = "swiftformat_library",
    _swiftformat_pkg = "swiftformat_pkg",
    _swiftformat_test = "swiftformat_test",
)

# Macros
swiftformat_pkg = _swiftformat_pkg
swiftformat_library = _swiftformat_library
swiftformat_binary = _swiftformat_binary
swiftformat_test = _swiftformat_test

# Rules
swiftformat_format = _swiftformat_format

# APIs
src_utils = _src_utils
