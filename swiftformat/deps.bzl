"""Dependencies for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swiftformat_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-1.4.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-1.4.1.tar.gz",
        ],
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "ee0033d029b5eaddc21836b2944cf37c95eb5f214eb39834136a316dbc252a73",
        urls = [
            "https://github.com/cgrindel/bazel-starlib/releases/download/v0.16.0/bazel-starlib.v0.16.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "rules_swift_package_manager",
        sha256 = "54f358ac1ed2bcf65404bc26c9d1298486ea88bfc230f452531e7ac26bcfca8b",
        urls = [
            "https://github.com/cgrindel/rules_swift_package_manager/releases/download/v0.4.3/rules_swift_package_manager.v0.4.3.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_swift",
        sha256 = "b98bd1ec03c713e2ff5c3aa8c05930d8b6ab85cc82b3ae5d869058da4731f230",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/1.8.0/rules_swift.1.8.0.tar.gz",
    )
