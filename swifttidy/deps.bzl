"""Dependencies for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swifttidy_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.8.1/bazel-skylib-1.8.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.8.1/bazel-skylib-1.8.1.tar.gz",
        ],
        sha256 = "51b5105a760b353773f904d2bbc5e664d0987fbaf22265164de65d43e910d8ac",
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "9d1bf18f859f16286cfe4157feb23beab6e79abe40620d0cb8f86fd0ba29e834",
        urls = [
            "https://github.com/cgrindel/bazel-starlib/releases/download/v0.22.0/bazel-starlib.v0.22.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_swift",
        sha256 = "9919ed1d8dae509645bfd380537ae6501528d8de971caebed6d5185b9970dc4d",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/2.1.1/rules_swift.2.1.1.tar.gz",
    )
