load(":swiftformat_format.bzl", "swiftformat_format")
load(":providers.bzl", "providers")
load("@bazel_skylib//rules:diff_test.bzl", "diff_test")

def swiftformat(name, srcs = None, output_dirname = ""):
    if srcs == None:
        srcs = native.glob(["*.swift"])
        # srcs = native.glob(["**/*.swift"], exclude = ["bazel-bin/**", "bazel-out/**"])

    # format_maps = [
    #     providers.format_map(
    #         src = src,
    #         out =
    #     )
    #     for src in srcs
    # ]

    for src in srcs:
        print("*** CHUCK src: ", src)
        # src_name = src.replace("/", "_")
        # format_name = name + "_format_" + src_name
        # swiftformat_format(
        #     name = format_name,
        #     srcs = [src],
        # )
