load(":swiftformat_format.bzl", "swiftformat_format")
load(":providers.bzl", "providers")
load("@bazel_skylib//rules:diff_test.bzl", "diff_test")

def swiftformat(name, srcs = None, output_dirname = ""):
    if srcs == None:
        srcs = native.glob(["*.swift"])

    for src in srcs:
        src_name = src.replace("/", "_")
        format_name = name + "_format_" + src_name
        swiftformat_format(
            name = format_name,
            srcs = [src],
        )
        diff_test(
            name = name + "_test_" + src_name,
            file1 = src,
            file2 = ":" + format_name,
        )
