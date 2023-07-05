"""Public API for rules_swiftformat."""

load(
    "//swifttidy/internal:src_utils.bzl",
    _src_utils = "src_utils",
)
load(
    "//swifttidy/internal:swiftformat_format.bzl",
    _swiftformat_format = "swiftformat_format",
)
load(
    "//swifttidy/internal:swiftformat_pkg.bzl",
    _swiftformat_pkg = "swiftformat_pkg",
)
load(
    "//swifttidy/toolchains:toolchain.bzl",
    _swiftformat_register_prebuilt_toolchains = "swiftformat_register_prebuilt_toolchains",
)

# Toolchain Registration
swiftformat_register_prebuilt_toolchains = _swiftformat_register_prebuilt_toolchains

# Macros
swiftformat_pkg = _swiftformat_pkg

# Rules
swiftformat_format = _swiftformat_format

# APIs
src_utils = _src_utils
