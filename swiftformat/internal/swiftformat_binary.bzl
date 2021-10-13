load("@build_bazel_rules_swift//swift:swift.bzl", "swift_binary")
load(":swiftformat_pkg.bzl", "swiftformat_pkg")

def swiftformat_binary(
        name,
        swiftformat_config = None,
        swiftformat_name = "swiftformat",
        srcs = None,
        **kwargs):
    # Define the swift binary
    swift_binary(
        name = name,
        srcs = srcs,
        **kwargs
    )

    # Define the swiftformat stuff
    swiftformat_pkg(
        name = swiftformat_name,
        srcs = srcs,
        conifg = swiftformat_config,
    )
