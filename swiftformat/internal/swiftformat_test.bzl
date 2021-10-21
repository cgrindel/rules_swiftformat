load("@build_bazel_rules_swift//swift:swift.bzl", "swift_test")
load(":swiftformat_pkg.bzl", "swiftformat_pkg")

def swiftformat_test(
        name,
        swiftformat_config = None,
        swiftformat_exclude = [],
        srcs = None,
        **kwargs):
    """Defines a `swift_test` along with a `swiftformat_pkg`.

    Args:
        name: The name for the swift_test as a `string`.
        swiftformat_config: A `label` for the SwiftFormat config file.
        swiftformat_exclude: A `list` of files or glob patterns that should
                             be ignored for formatting.
        srcs: The Swift sources that should be used by the `swift_test` and the `swiftformat_pkg`.
        **kwargs: The attributes for `swift_test`.

    Returns:
        None.
    """

    # Define the swift binary
    swift_test(
        name = name,
        srcs = srcs,
        **kwargs
    )

    # Define the swiftformat stuff
    swiftformat_name = name + "_swiftformat"
    swiftformat_pkg(
        name = swiftformat_name,
        srcs = native.glob(srcs, exclude = swiftformat_exclude),
        config = swiftformat_config,
    )
