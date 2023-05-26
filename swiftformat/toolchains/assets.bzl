"""Support downloading prebuilt SwiftFormat binaries."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _create(os, cpu, file, archive = None):
    if archive == None:
        archive = file + ".zip"
    repo = "swiftformat_download_{}_{}".format(os, cpu)
    swiftformat_toolchain_name = "download_{}_{}".format(os, cpu)
    toolchain_name = swiftformat_toolchain_name + "_toolchain"
    return struct(
        os = os,
        cpu = cpu,
        file = file,
        archive = archive,
        repo = repo,
        swiftformat_toolchain_name = swiftformat_toolchain_name,
        toolchain_name = toolchain_name,
        executable_label = "@{repo}//:{file}".format(
            file = file,
            repo = repo,
        ),
    )

_ALL_ASSETS = [
    _create(
        os = "macos",
        cpu = "x86_64",
        file = "swiftformat",
    ),
    _create(
        os = "macos",
        cpu = "arm64",
        file = "swiftformat",
    ),
    _create(
        os = "linux",
        cpu = "x86_64",
        file = "swiftformat_linux",
    ),
]

assets = struct(
    create = _create,
    all = _ALL_ASSETS,
)

# MARK: - Repository Rules

_SWIFTFORMAT_DOWNLOAD_URL_TEMPLATE = """\
https://github.com/nicklockwood/SwiftFormat/releases/download/{version}/{archive}\
"""

def _urls(asset, version):
    return [
        _SWIFTFORMAT_DOWNLOAD_URL_TEMPLATE.format(
            version = version,
            archive = asset.archive,
        ),
    ]

# buildifier: disable=unnamed-macro
def swiftformat_register_toolchains(version, register_toolchains = True):
    """Register the toolchains for SwiftFormat.

    Args:
        version: The SwiftFormat version as a `string`.
        register_toolchains: Optional. A `bool` that determines whether this
            function should call `register_toolchains()`
    """
    repos = {}
    for asset in _ALL_ASSETS:
        repo = repos.get(asset.repo)
        if repo != None:
            continue
        repos[asset.repo] = struct(
            name = asset.repo,
            urls = _urls(asset, version),
            file = asset.file,
        )
    for repo in repos.values():
        http_archive(
            name = repo.name,
            urls = repo.urls,
            build_file_content = """\
package(default_visibility = ["//visibility:public"])

exports_files(["{file}"])
""".format(file = repo.file),
        )
    if register_toolchains:
        native.register_toolchains(
            "@cgrindel_rules_swiftformat//swiftformat/toolchains:all",
        )
