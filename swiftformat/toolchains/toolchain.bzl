"""Define the toolchains for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":prebuilt_assets.bzl", "prebuilt_assets")

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

# Update this list by running the following and copying the `assets` list values.
# `bazel run //tools:generate_assets_declaration -- "0.51.11"`
DEFAULT_SWIFTFORMAT_ASSETS = [
    prebuilt_assets.create_swiftformat(
        version = "0.51.11",
        os = "macos",
        cpu = "x86_64",
        sha256 = "e565ebf6c54ee8e1ac83e4974edae34e002f86eda358a5838c0171f32f00ab20",
    ),
    prebuilt_assets.create_swiftformat(
        version = "0.51.11",
        os = "macos",
        cpu = "arm64",
        sha256 = "e565ebf6c54ee8e1ac83e4974edae34e002f86eda358a5838c0171f32f00ab20",
    ),
    prebuilt_assets.create_swiftformat(
        version = "0.51.11",
        os = "linux",
        cpu = "x86_64",
        sha256 = "a49b79d97c234ccb5bcd2064ffec868e93e2eabf2d5de79974ca3802d8e389ec",
    ),
]

def _swiftformat_toolchain_setup_impl(repository_ctx):
    assets = prebuilt_assets.from_json(repository_ctx.attr.assets_json)
    content = """\
load("@rules_swift_tidy//swiftformat/toolchains:toolchain.bzl", "swiftformat_toolchain")

"""
    for asset in assets:
        content += """\
swiftformat_toolchain(
    name = "{swiftformat_toolchain_name}",
    tool = "{executable_label}",
)

toolchain(
    name = "{toolchain_name}",
    exec_compatible_with = [
        "@platforms//os:{os}",
        "@platforms//cpu:{cpu}",
    ],
    toolchain = "{swiftformat_toolchain_name}",
    toolchain_type = "@rules_swift_tidy//swiftformat:toolchain",
)
""".format(
            cpu = asset.cpu,
            executable_label = asset.executable_label,
            os = asset.os,
            swiftformat_toolchain_name = asset.swiftformat_toolchain_name,
            toolchain_name = asset.toolchain_name,
        )
    repository_ctx.file("BUILD.bazel", content)

_swiftformat_toolchain_setup = repository_rule(
    implementation = _swiftformat_toolchain_setup_impl,
    attrs = {
        "assets_json": attr.string(
            doc = "The assets to download encoded as JSON.",
            mandatory = True,
        ),
    },
    doc = "Declares the toolchains for the provided assets.",
)

def swiftformat_register_prebuilt_toolchains(
        name = "swift_tidy_prebuilt_toolchains",
        swiftformat_assets = None,
        register_toolchains = True):
    """Register and configure the toolchains to download pre-built SwiftFormat \
    binaries.

    Args:
        name: Optional. The name for the toolchains repository as a `string`.
        swiftformat_assets: Optional. A `list` of tools to register. If not
            specified, it uses a recent version of SwiftFormat.
        register_toolchains: Optional. A `bool` that determines whether this
            function should call `register_toolchains()`.
    """
    if swiftformat_assets == None:
        swiftformat_assets = DEFAULT_SWIFTFORMAT_ASSETS
    toolchain_labels = []
    for asset in swiftformat_assets:
        toolchain_label = "@{repo}//:{name}".format(
            repo = name,
            name = asset.toolchain_name,
        )
        toolchain_labels.append(toolchain_label)
        http_archive(
            name = asset.repo,
            urls = asset.urls,
            sha256 = asset.sha256,
            build_file_content = """\
package(default_visibility = ["//visibility:public"])

genrule(
    name = "executable",
    srcs = ["{file}"],
    outs = ["swiftformat_exec"],
    executable = True,
    cmd = "cp $< $@ && chmod +x $@",
)
""".format(file = asset.file),
        )

    _swiftformat_toolchain_setup(
        name = name,
        assets_json = json.encode(swiftformat_assets),
    )

    if register_toolchains:
        native.register_toolchains(*toolchain_labels)
