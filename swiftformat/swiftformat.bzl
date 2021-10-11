load(
    "//swiftformat/internal:swiftformat_pkg.bzl",
    _swiftformat_pkg = "swiftformat_pkg",
)
load(
    "//swiftformat/internal:swiftformat_update_all.bzl",
    _swiftformat_update_all = "swiftformat_update_all",
)

swiftformat_pkg = _swiftformat_pkg
swiftformat_update_all = _swiftformat_update_all
