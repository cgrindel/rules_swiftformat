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

    maybe(
        http_archive,
        name = "cgrindel_bazel_starlib",
        sha256 = "238c05abf31447b93bd15b616c7413c4c719ee7b5e81c1489ca20f02ce628489",
        strip_prefix = "bazel-starlib-0.2.0",
        urls = [
            "http://github.com/cgrindel/bazel-starlib/archive/v0.2.0.tar.gz",
        ],
    )

    # TODO: FIX ME

    # maybe(
    #     http_archive,
    #     name = "cgrindel_rules_spm",
    #     sha256 = "fab28a41793744f3944ad2606cdd9c0f8e2f4861dd29fb1d61aa4263c7a1400a",
    #     strip_prefix = "rules_spm-0.6.0",
    #     urls = ["https://github.com/cgrindel/rules_spm/archive/v0.6.0.tar.gz"],
    # )

    maybe(
        native.local_repository,
        name = "cgrindel_rules_spm",
        path = "/Users/chuck/code/cgrindel/rules_spm",
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_bazel_integration_test",
        sha256 = "50b808269ee09373c099256103c40629db8a66fd884030d7a36cf9a2e8675b75",
        strip_prefix = "rules_bazel_integration_test-0.3.1",
        urls = ["https://github.com/cgrindel/rules_bazel_integration_test/archive/v0.3.1.tar.gz"],
    )
