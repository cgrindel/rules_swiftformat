load("@bazel_skylib//lib:paths.bzl", "paths")
load(
    "@cgrindel_rules_updatesrc//updatesrc:updatesrc.bzl",
    "UpdateSrcsInfo",
    "update_srcs",
)

"""A build rule that formats Swift source files.
"""

def _swiftformat_format_impl(ctx):
    updsrcs = []
    for src in ctx.files.srcs:
        out = ctx.actions.declare_file(src.basename + ctx.attr.output_suffix)
        updsrcs.append(update_srcs.create(src = src, out = out))
        inputs = [src]

        args = ctx.actions.args()
        if ctx.file.config != None:
            args.add_all(["--config", ctx.file.config])
            inputs.append(ctx.file.config)

        if ctx.attr.swift_version != "":
            args.add_all(["--swiftversion", ctx.attr.swift_version])

        args.add_all([
            "--quiet",
            "--symlinks",
            "follow",
            "--cache",
            "ignore",
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
        DefaultInfo(files = depset([updsrc.out for updsrc in updsrcs])),
        UpdateSrcsInfo(update_srcs = depset(updsrcs)),
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
            doc = """\
The Swift version to be used by `swiftformat`. You probably want to add this \
to your config file instead of adding it here.\
""",
        ),
        "config": attr.label(
            allow_single_file = True,
            doc = "A swiftformat config file.",
            default = "@//:.swiftformat",
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
