load("@bazel_skylib//lib:paths.bzl", "paths")
load(":providers.bzl", "SwiftFormatInfo")

def _swiftformat_format_impl(ctx):
    outputs = []
    format_map = {}
    for src in ctx.files.srcs:
        out = ctx.actions.declare_file(src.basename + ctx.attr.output_suffix)
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

swiftformat_format = rule(
    implementation = _swiftformat_format_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "output_suffix": attr.string(
            default = "_formatted",
            doc = "The suffix to add to the output filename.",
        ),
        # "output_dirname": attr.string(
        #     default = "formatted",
        #     doc = "The name of the directory that contains the formatted files.",
        # ),
        "_swiftformat": attr.label(
            default = "@swiftformat_repos//SwiftFormat:swiftformat",
            executable = True,
            cfg = "host",
            allow_files = True,
        ),
    },
    doc = "Formats the provided source files.",
)
