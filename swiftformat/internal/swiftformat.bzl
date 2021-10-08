load(":swiftformat_format.bzl", "swiftformat_format")

def swiftformat(name, srcs = None):
    if srcs == None:
        srcs = native.glob(["*.swift"])
    format_name = name + "_format"

    swiftformat_format(
        name = format_name,
        srcs = srcs,
    )
