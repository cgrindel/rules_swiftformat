"""Dependencies for rules_swiftformat."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swifttidy_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.4.2/bazel-skylib-1.4.2.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.2/bazel-skylib-1.4.2.tar.gz",
        ],
        sha256 = "66ffd9315665bfaafc96b52278f57c7e2dd09f5ede279ea6d39b2be471e7e3aa",
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "04be4d5aa5d8ec77a62fe84250cc300967bc5f06cd981892c8456be4c528ab40",
        urls = [
            "https://github.com/cgrindel/bazel-starlib/releases/download/v0.16.1/bazel-starlib.v0.16.1.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_swift",
        sha256 = "b3b6c5c9f2a589150f71e79dec1e1ed0eb974dbd49e9317df4e09e08ff6e83df",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/1.9.1/rules_swift.1.9.1.tar.gz",
    )
