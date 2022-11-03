"""Dependencies for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swiftformat_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        ],
        sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "116bfd53999992c21b758a9854af29dfd77470f8d9f919be81e2034f003a5b31",
        strip_prefix = "bazel-starlib-999.0.0",
        urls = [
            "http://github.com/cgrindel/bazel-starlib/archive/v999.0.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_spm",
        sha256 = "cbe5d5dccdc8d5aa300e1538c4214f44a1266895d9817e8279a9335bcbee2f1e",
        strip_prefix = "rules_spm-0.7.0",
        urls = [
            "http://github.com/cgrindel/rules_spm/archive/v0.7.0.tar.gz",
        ],
    )
