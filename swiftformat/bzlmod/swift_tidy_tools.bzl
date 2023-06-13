"""Extension for downloading the tools used by `rules_swift_tidy`."""

load("//swiftformat/toolchains:prebuilt_assets.bzl", "prebuilt_assets")
load(
    "//swiftformat/toolchains:toolchain.bzl",
    "swiftformat_register_prebuilt_toolchains",
)

def _swift_tidy_tools_impl(module_ctx):
    assets_by_type = {}

    def add_asset(type, asset):
        assets = assets_by_type.get(type, [])
        assets.append(asset)  # buildifier: disable=uninitialized
        assets_by_type[type] = assets

    for mod in module_ctx.modules:
        for swf in mod.tags.swiftformat:
            asset = prebuilt_assets.create_swiftformat(
                version = swf.version,
                os = swf.os,
                cpu = swf.cpu,
                sha256 = swf.sha256,
            )
            add_asset("swiftformat", asset)

    swiftformat_register_prebuilt_toolchains(
        swiftformat_assets = assets_by_type.get("swiftformat"),
        register_toolchains = False,
    )

_swiftformat_tag = tag_class(
    attrs = {
        "cpu": attr.string(
            values = ["x86_64", "arm64"],
            mandatory = True,
            doc = "The cpu architeture for the SwiftFormat executable.",
        ),
        "os": attr.string(
            values = ["macos", "linux"],
            mandatory = True,
            doc = "The operating system for the SwiftFormat executable.",
        ),
        "sha256": attr.string(
            doc = "The SHA256 value for the archive file.",
        ),
        "version": attr.string(
            mandatory = True,
            doc = "The version of SwiftFormat to download.",
        ),
    },
    doc = "Identifies the SwiftFormat binaries to register.",
)

swift_tidy_tools = module_extension(
    implementation = _swift_tidy_tools_impl,
    tag_classes = {"swiftformat": _swiftformat_tag},
    doc = """\
Provides a means for clients to download the tools used by `rules_swift_tidy`.\
""",
)
