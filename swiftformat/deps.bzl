load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swiftformat_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        ],
        sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    )

    http_archive(
        name = "cgrindel_bazel_starlib",
        sha256 = "5b36e7f11bf0c1d52480f1b022430611b402b5424979f280f13c52550de76584",
        strip_prefix = "bazel-starlib-0.3.0",
        urls = [
            "http://github.com/cgrindel/bazel-starlib/archive/v0.3.0.tar.gz",
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

    maybe(
        http_archive,
        name = "cgrindel_rules_bazel_integration_test",
        sha256 = "50b808269ee09373c099256103c40629db8a66fd884030d7a36cf9a2e8675b75",
        strip_prefix = "rules_bazel_integration_test-0.3.1",
        urls = ["https://github.com/cgrindel/rules_bazel_integration_test/archive/v0.3.1.tar.gz"],
    )
