"""Dependencies for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swifttidy_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
        ],
        sha256 = "cd55a062e763b9349921f0f5db8c3933288dc8ba4f76dd9416aac68acee3cb94",
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "8389deb2d177b3f099fbb1d2733c2e45d07f7b26b1fb5cabc15a7e21594af63b",
        urls = [
            "https://github.com/cgrindel/bazel-starlib/releases/download/v0.20.0/bazel-starlib.v0.20.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_swift",
        sha256 = "9bc9dc949062405412404c0f07f7323ba310f3f91f42af414ac27e338ba7bb8c",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/1.17.0/rules_swift.1.17.0.tar.gz",
    )
