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
        sha256 = "df971d4736cf30ab5332536715eeb00c1a67ca6440610e8bc3b73a35aaff34dc",
        strip_prefix = "bazel-starlib-0.16.0",
        urls = [
            "http://github.com/cgrindel/bazel-starlib/archive/v0.16.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_spm",
        sha256 = "777e687245faa7340488e61f5abb23b95b4c0e27e05f7cea7318c03e4cc38289",
        strip_prefix = "rules_spm-0.11.2",
        urls = [
            "http://github.com/cgrindel/rules_spm/archive/v0.11.2.tar.gz",
        ],
    )
