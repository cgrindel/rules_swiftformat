load("@bazel_skylib//lib:paths.bzl", "paths")
load(":providers.bzl", "SwiftFormatInfo")

"""A build rule that formats Swift source files.
"""

def _swiftformat_format_impl(ctx):
    outputs = []
    format_map = {}
    for src in ctx.files.srcs:
        out = ctx.actions.declare_file(src.basename + ctx.attr.output_suffix)
        outputs.append(out)
        format_map[src] = out
        inputs = [src]

        args = ctx.actions.args()
        if ctx.file.config != None:
            args.add_all(["--config", ctx.file.config])
            inputs.append(ctx.file.config)

        args.add_all([
            "--quiet",
            "--symlinks",
            "follow",
            "--cache",
            "ignore",
            "--swiftversion",
            ctx.attr.swift_version,
            "--output",
            out.path,
            src.path,
        ])
        ctx.actions.run(
            outputs = [out],
            inputs = inputs,
            executable = ctx.executable._swiftformat,
            arguments = [args],
        )

    return [
        DefaultInfo(files = depset(outputs)),
        SwiftFormatInfo(format_map = format_map),
    ]

swiftformat_format = rule(
    implementation = _swiftformat_format_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
            doc = "The Swift source files to format.",
        ),
        "swift_version": attr.string(
            default = "5.4",
            doc = "The Swift version to be used by `swiftformat`",
        ),
        "config": attr.label(
            allow_single_file = True,
            doc = "A swiftformat YAML config file.",
        ),
        "output_suffix": attr.string(
            default = "_formatted",
            doc = "The suffix to add to the output filename.",
        ),
        "_swiftformat": attr.label(
            default = "@swiftformat_repos//SwiftFormat:swiftformat",
            executable = True,
            cfg = "host",
            allow_files = True,
            doc = "The `swiftformat` executable.",
        ),
    },
    doc = "Formats the Swift source files using `nicklockwood/SwiftFormat`.",
)
