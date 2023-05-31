"""Public API for rules_swiftformat."""

load(
    "//swiftformat/internal:src_utils.bzl",
    _src_utils = "src_utils",
)
load(
    "//swiftformat/internal:swiftformat_binary.bzl",
    _swiftformat_binary = "swiftformat_binary",
)
load(
    "//swiftformat/internal:swiftformat_format.bzl",
    _swiftformat_format = "swiftformat_format",
)
load(
    "//swiftformat/internal:swiftformat_library.bzl",
    _swiftformat_library = "swiftformat_library",
)
load(
    "//swiftformat/internal:swiftformat_pkg.bzl",
    _swiftformat_pkg = "swiftformat_pkg",
)
load(
    "//swiftformat/internal:swiftformat_test.bzl",
    _swiftformat_test = "swiftformat_test",
)
load(
    "//swiftformat/toolchains:toolchain.bzl",
    _swiftformat_register_prebuilt_toolchains = "swiftformat_register_prebuilt_toolchains",
)

# Toolchain Registration
swiftformat_register_prebuilt_toolchains = _swiftformat_register_prebuilt_toolchains

# Macros
swiftformat_pkg = _swiftformat_pkg
swiftformat_library = _swiftformat_library
swiftformat_binary = _swiftformat_binary
swiftformat_test = _swiftformat_test

# Rules
swiftformat_format = _swiftformat_format

# APIs
src_utils = _src_utils
