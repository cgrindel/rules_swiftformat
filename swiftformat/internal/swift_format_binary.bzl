load("@build_bazel_rules_swift//swift:swift.bzl", "swift_binary")
load(":swiftformat_pkg.bzl", "swiftformat_pkg")

def swiftformat_binary(name, swiftformat_config = None, srcs = None, **kwargs):
    # Define the swift binary
    swift_library(
        name = name,
        srcs = srcs,
        **kwargs
    )

    # Define the swiftformat stuff
    swiftformat_pkg(
        name = "swiftformat",
        srcs = srcs,
        conifg = swiftformat_config,
    )
