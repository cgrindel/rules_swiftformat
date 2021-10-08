load(
    "//swiftformat/internal:swiftformat_format.bzl",
    _swiftformat_format = "swiftformat_format",
)
load(
    "//swiftformat/internal:swiftformat.bzl",
    _swiftformat = "swiftformat",
)

swiftformat_format = _swiftformat_format
swiftformat = _swiftformat
