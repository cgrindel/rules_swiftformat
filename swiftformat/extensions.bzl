"""Bazel Module Extensions"""

load(
    "//swiftformat/bzlmod:swift_tidy_tools.bzl",
    _swift_tidy_tools = "swift_tidy_tools",
)

swift_tidy_tools = _swift_tidy_tools
