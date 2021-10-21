load(":src_utils.bzl", "src_utils")
load(":swiftformat_format.bzl", "swiftformat_format")
load(":swiftformat_update.bzl", "swiftformat_update")
load("@bazel_skylib//rules:diff_test.bzl", "diff_test")

"""A macro which defines targets that format Swift source files, test that 
they are formatted and copies them to the workspace directory.
"""

def swiftformat_pkg(name, srcs = None, config = None):
    """Defines targets that will format, test and update the specified Swift sources.

    NOTE: Any labels detected in the `srcs` will be ignored.

    Args:
        name: The base name for the targets that will be defined.
        srcs: Optional. The Swift source files that should be formatted.
        config: Optional. The swiftformat YAML configuration file.

    Returns:
        None.
    """
    if srcs == None:
        srcs = native.glob(["*.swift"])

    # Only process paths; ignore labels
    src_paths = [src for src in srcs if src_utils.is_path(src)]

    format_names = []
    for src in src_paths:
        src_name = src.replace("/", "_")
        format_name = name + "_fmt_" + src_name
        format_names.append(":" + format_name)

        swiftformat_format(
            name = format_name,
            srcs = [src],
            config = config,
        )
        diff_test(
            name = name + "_test_" + src_name,
            file1 = src,
            file2 = ":" + format_name,
        )

    swiftformat_update(
        name = name + "_update",
        formats = format_names,
    )
