"""Define the toolchains for rules_swiftformat."""

SwiftformatInfo = provider(
    doc = "Provider for Swiftformat toolchain.",
    fields = {
        "executable": "The swiftformat executable as a `File`.",
    },
)

def _swiftformat_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        swiftformat_info = SwiftformatInfo(
            executable = ctx.file.tool_executable,
        ),
    )
    return [toolchain_info]

swiftformat_toolchain = rule(
    implementation = _swiftformat_toolchain_impl,
    attrs = {
        "tool_executable": attr.label(
            allow_single_file = True,
            executable = True,
            cfg = "exec",
            doc = "The `swiftformat` executable.",
        ),
    },
    doc = "",
)
