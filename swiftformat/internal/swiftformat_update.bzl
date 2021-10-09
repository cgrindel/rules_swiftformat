load(":providers.bzl", "SwiftFormatInfo")
load("@bazel_skylib//lib:dicts.bzl", "dicts")

def _swiftformat_update(ctx):
    formats = [
        fmt[SwiftFormatInfo].format_map
        for fmt in ctx.attr.formats
    ]
    format_map = dicts.add(*formats)

    runfiles = ctx.runfiles(
        files = [format_map[src] for src in format_map],
    )

    update = ctx.actions.declare_file("update.sh")
    ctx.actions.write(
        output = update,
        content = """
#!/usr/bin/env bash
runfiles_dir=$(pwd)
echo >&2 "*** CHUCK:  runfiles_dir: ${runfiles_dir}" 
ls -l
tree
cd $BUILD_WORKSPACE_DIRECTORY
ls -l "${runfiles_dir}"
ls -l "${runfiles_dir}/main.swift_formatted"
set -x
""" + "\n".join([
            # "cp -fv \"${{runfiles_dir}}/{fmt}\" {src}".format(
            "cp -fv $(realpath \"${{runfiles_dir}}/{fmt}\") {src}".format(
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
)
