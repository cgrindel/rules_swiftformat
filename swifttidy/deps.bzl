"""Dependencies for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swifttidy_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.8.2/bazel-skylib-1.8.2.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.8.2/bazel-skylib-1.8.2.tar.gz",
        ],
        sha256 = "6e78f0e57de26801f6f564fa7c4a48dc8b36873e416257a92bbb0937eeac8446",
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "43e375213dabe0c3928e65412ea7ec16850db93285c8c6f8b0eaa41cacd0f882",
        urls = [
            "https://github.com/cgrindel/bazel-starlib/releases/download/v0.21.0/bazel-starlib.v0.21.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_swift",
        sha256 = "9919ed1d8dae509645bfd380537ae6501528d8de971caebed6d5185b9970dc4d",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/2.1.1/rules_swift.2.1.1.tar.gz",
    )
