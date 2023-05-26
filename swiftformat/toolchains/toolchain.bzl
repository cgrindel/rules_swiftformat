"""Define the toolchains for rules_swiftformat."""

load(":assets.bzl", "assets")

SwiftformatInfo = provider(
    doc = "Provider for Swiftformat toolchain.",
    fields = {
        "executable": "The swiftformat executable as a `File`.",
    },
)

def _swiftformat_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        swiftformat_info = SwiftformatInfo(
            executable = ctx.file.tool,
        ),
    )
    return [toolchain_info]

swiftformat_toolchain = rule(
    implementation = _swiftformat_toolchain_impl,
    attrs = {
        "tool": attr.label(
            allow_single_file = True,
            mandatory = True,
            executable = True,
            cfg = "exec",
            doc = "The `swiftformat` executable.",
        ),
    },
    provides = [platform_common.ToolchainInfo],
    doc = "Define a toolchain for Swiftformat.",
)

# buildifier: disable=unnamed-macro
def declare_swiftformat_toolchains():
    """Declare the SwiftFormat toolchain targets.
    """
    for asset in assets.all:
        swiftformat_toolchain(
            name = asset.swiftformat_toolchain_name,
            tool = asset.executable_label,
        )

        native.toolchain(
            name = asset.toolchain_name,
            exec_compatible_with = [
                "@platforms//os:{}".format(asset.os),
                "@platforms//cpu:{}".format(asset.cpu),
            ],
            toolchain = asset.swiftformat_toolchain_name,
            toolchain_type = "//swiftformat:toolchain",
        )
