load(
    "//swiftformat/internal:swiftformat_pkg.bzl",
    _swiftformat_pkg = "swiftformat_pkg",
)
load(
    "//swiftformat/internal:swiftformat_update_all.bzl",
    _swiftformat_update_all = "swiftformat_update_all",
)
load(
    "//swiftformat/internal:swiftformat_format.bzl",
    _swiftformat_format = "swiftformat_format",
)
load(
    "//swiftformat/internal:swiftformat_update.bzl",
    _swiftformat_update = "swiftformat_update",
)
load(
    "//swiftformat/internal:providers.bzl",
    _SwiftFormatInfo = "SwiftFormatInfo",
)
load(
    "//swiftformat/internal:swiftformat_library.bzl",
    _swiftformat_library = "swiftformat_library",
)
load(
    "//swiftformat/internal:swiftformat_binary.bzl",
    _swiftformat_binary = "swiftformat_binary",
)
load(
    "//swiftformat/internal:swiftformat_test.bzl",
    _swiftformat_test = "swiftformat_test",
)
load(
    "//swiftformat/internal:src_utils.bzl",
    _src_utils = "src_utils",
)

# Macros
swiftformat_pkg = _swiftformat_pkg
swiftformat_update_all = _swiftformat_update_all
swiftformat_library = _swiftformat_library
swiftformat_binary = _swiftformat_binary
swiftformat_test = _swiftformat_test

# Rules
swiftformat_format = _swiftformat_format
swiftformat_update = _swiftformat_update

# Providers
SwiftFormatInfo = _SwiftFormatInfo

# APIs
src_utils = _src_utils
