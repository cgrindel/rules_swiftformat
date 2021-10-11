load(
    "//swiftformat/internal:swiftformat.bzl",
    _swiftformat = "swiftformat",
)
load(
    "//swiftformat/internal:swiftformat_update_all.bzl",
    _swiftformat_update_all = "swiftformat_update_all",
)

swiftformat = _swiftformat
swiftformat_update_all = _swiftformat_update_all
