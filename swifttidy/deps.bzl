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
        sha256 = "a8d25340956b429b56302d3fd702bb3df8b3a67db248dd32b3084891ad497964",
        urls = [
            "https://github.com/cgrindel/bazel-starlib/releases/download/v0.17.0/bazel-starlib.v0.17.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "build_bazel_rules_swift",
        sha256 = "b1de723ff0dc433ac4ddfc6a7e8635bd4fb10c44d42d20a433de854196777f3d",
        url = "https://github.com/bazelbuild/rules_swift/releases/download/1.10.1/rules_swift.1.10.1.tar.gz",
    )
