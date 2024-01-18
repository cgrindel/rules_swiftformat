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
        sha256 = "b9c88ac51ccaa0635621111308b85fdbb2606adb864596f9842aa5f7480cfe3a",
        urls = [
            "https://github.com/cgrindel/bazel-starlib/releases/download/v0.19.0/bazel-starlib.v0.19.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_swift",
        sha256 = "7a9f6b16ef71d54485b1f7a0c8d58815461c4d5ba356c0108b8dbe92d354ff7b",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/1.15.0/rules_swift.1.15.0.tar.gz",
    )
