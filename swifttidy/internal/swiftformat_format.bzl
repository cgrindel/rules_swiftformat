"""A build rule that formats Swift source files. """

load(
    "@cgrindel_bazel_starlib//updatesrc:defs.bzl",
    "UpdateSrcsInfo",
    "update_srcs",
)

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

        toolchain_info = ctx.toolchains["@rules_swift_tidy//swifttidy:toolchain"]
        swiftformat_info = toolchain_info.swiftformat_info
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
            executable = swiftformat_info.executable,
            arguments = [args],
            # This allows LD_LIBRARY_PATH to be used for finding dynamically
            # linked libraries like libFoundation.so.
            use_default_shell_env = True,
        )

    return [
        DefaultInfo(files = depset([updsrc.out for updsrc in updsrcs])),
        UpdateSrcsInfo(update_srcs = depset(updsrcs)),
    ]

swiftformat_format = rule(
    implementation = _swiftformat_format_impl,
    attrs = {
        "config": attr.label(
            allow_single_file = True,
            doc = "A swiftformat config file.",
            # TODO(chuck): Figure out how to provide default.
            # default = "@//:.swiftformat",
        ),
        "output_suffix": attr.string(
            default = "_formatted",
            doc = "The suffix to add to the output filename.",
        ),
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
    },
    toolchains = ["@rules_swift_tidy//swifttidy:toolchain"],
    doc = "Formats the Swift source files using `nicklockwood/SwiftFormat`.",
)
