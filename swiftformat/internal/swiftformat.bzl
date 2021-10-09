load(":swiftformat_format.bzl", "swiftformat_format")
load(":swiftformat_update.bzl", "swiftformat_update")
load("@bazel_skylib//rules:diff_test.bzl", "diff_test")

def swiftformat(name, srcs = None, config = None):
    if srcs == None:
        srcs = native.glob(["*.swift"])

    format_names = []
    for src in srcs:
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
