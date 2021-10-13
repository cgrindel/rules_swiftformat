load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load(":swiftformat_pkg.bzl", "swiftformat_pkg")

def swiftformat_library(
        name,
        swiftformat_config = None,
        swiftformat_name = "swiftformat",
        srcs = None,
        **kwargs):
    # Define the swift library
    swift_library(
        name = name,
        srcs = srcs,
        **kwargs
    )

    # Define the swiftformat stuff
    swiftformat_pkg(
        name = swiftformat_name,
        srcs = srcs,
        config = swiftformat_config,
    )
