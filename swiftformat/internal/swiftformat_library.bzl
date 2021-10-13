load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load(":swiftformat_pkg.bzl", "swiftformat_pkg")

def swiftformat_library(
        name,
        swiftformat_config = None,
        swiftformat_name = "swiftformat",
        srcs = None,
        **kwargs):
    """Defines a `swift_library` along with a `swiftformat_pkg`.

    Args:
        name: The name for the swift_library as a `string`.
        swiftformat_config: A `label` for the SwiftFormat config file.
        swiftformat_name: Optional. The name for the `swiftformat_pkg`.
        srcs: The Swift sources that should be used by the `swift_library` and the `swiftformat_pkg`.
        **kwargs: The attributes for `swift_library`.

    Returns:
        None.
    """

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
