load(":providers.bzl", "SwiftFormatInfo")
load("@bazel_skylib//lib:dicts.bzl", "dicts")

"""A binary rule that copies the formatted Swift sources to the workspace 
directory.
"""

def _swiftformat_update(ctx):
    formats = [
        fmt[SwiftFormatInfo].format_map
        for fmt in ctx.attr.formats
    ]
    format_map = dicts.add(*formats)

    runfiles = ctx.runfiles(
        files = [format_map[src] for src in format_map],
    )

    update = ctx.actions.declare_file("update_with_formatted.sh")
    ctx.actions.write(
        output = update,
        content = """
#!/usr/bin/env bash
runfiles_dir=$(pwd)
cd $BUILD_WORKSPACE_DIRECTORY
""" + "\n".join([
            "cp -f $(realpath \"${{runfiles_dir}}/{fmt}\") {src}".format(
                src = src.short_path,
                fmt = format_map[src].short_path,
            )
            for src in format_map
        ]),
        is_executable = True,
    )

    return DefaultInfo(executable = update, runfiles = runfiles)

swiftformat_update = rule(
    implementation = _swiftformat_update,
    attrs = {
        "formats": attr.label_list(
            providers = [[SwiftFormatInfo]],
            doc = "The format build targets.",
        ),
    },
    executable = True,
    doc = "Copies the formatted Swift sources to the workspace directory.",
)
