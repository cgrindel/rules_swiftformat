"""Dependencies for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swiftformat_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        ],
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "3a3b3a5e9b0f63e8a9a193a66bc588c1f2fb2873562be68f2026adb815eea06f",
        strip_prefix = "bazel-starlib-0.8.0",
        urls = [
            "http://github.com/cgrindel/bazel-starlib/archive/v0.8.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_spm",
        sha256 = "d36697e83720e4dc29a97c7a8f1a02858b3c6ce51fa645be3faa03f51dbc1151",
        strip_prefix = "rules_spm-0.11.1",
        urls = [
            "http://github.com/cgrindel/rules_spm/archive/v0.11.1.tar.gz",
        ],
    )
