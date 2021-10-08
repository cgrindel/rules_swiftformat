load("@bazel_skylib//lib:paths.bzl", "paths")
load(":providers.bzl", "SwiftFormatInfo")

def _swiftformat_impl(ctx):
    outputs = []
    format_map = {}
    for src in ctx.files.srcs:
        out = ctx.actions.declare_file(paths.join(_FORMAT_DIRNAME, src.path))
        outputs.append(out)
        format_map[src] = out
        ctx.actions.run(
            outputs = [out],
            inputs = [src],
            executable = ctx.executable._swiftformat,
            arguments = [
                "--symlinks",
                "follow",
                "--cache",
                "ignore",
                "--swiftversion",
                "5.4",
                "--output",
                out.path,
                src.path,
            ],
        )

    return [
        DefaultInfo(files = depset(outputs)),
        SwiftFormatInfo(format_map = format_map),
    ]

swiftformat = rule(
    implementation = _swiftformat_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "_swiftformat": attr.label(
            default = "@swift_utils//SwiftFormat:swiftformat",
            executable = True,
            cfg = "host",
            allow_files = True,
        ),
    },
    doc = "Formats the provided source files.",
)
