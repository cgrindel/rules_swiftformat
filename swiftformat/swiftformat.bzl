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

# Macros
swiftformat_pkg = _swiftformat_pkg
swiftformat_update_all = _swiftformat_update_all

# Rules
swiftformat_format = _swiftformat_format
swiftformat_update = _swiftformat_update

# Providers
SwiftFormatInfo = _SwiftFormatInfo
