load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def swiftformat_rules_dependencies():
    """Loads the dependencies for `rules_swiftformat`."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_updatesrc",
        sha256 = "18eb6620ac4684c2bc722b8fe447dfaba76f73d73e2dfcaf837f542379ed9bc3",
        strip_prefix = "rules_updatesrc-0.1.0",
        urls = ["https://github.com/cgrindel/rules_updatesrc/archive/v0.1.0.tar.gz"],
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_doc",
        sha256 = "3ccc6d205a7f834c5e89adcb4bc5091a9a07a69376107807eb9aea731ce92854",
        strip_prefix = "bazel-doc-0.1.2",
        urls = ["https://github.com/cgrindel/bazel-doc/archive/v0.1.2.tar.gz"],
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_bzlformat",
        sha256 = "44b09ad9c5395760065820676ba6e65efec08ae02c1ce7e2d39d42c5b1e7aec8",
        strip_prefix = "rules_bzlformat-0.2.1",
        urls = ["https://github.com/cgrindel/rules_bzlformat/archive/v0.2.1.tar.gz"],
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_spm",
        sha256 = "fab28a41793744f3944ad2606cdd9c0f8e2f4861dd29fb1d61aa4263c7a1400a",
        strip_prefix = "rules_spm-0.6.0",
        urls = ["https://github.com/cgrindel/rules_spm/archive/v0.6.0.tar.gz"],
    )

    maybe(
        http_archive,
        name = "cgrindel_rules_bazel_integration_test",
        sha256 = "50b808269ee09373c099256103c40629db8a66fd884030d7a36cf9a2e8675b75",
        strip_prefix = "rules_bazel_integration_test-0.3.1",
        urls = ["https://github.com/cgrindel/rules_bazel_integration_test/archive/v0.3.1.tar.gz"],
    )

    maybe(
        http_archive,
        name = "cgrindel_bazel_shlib",
        sha256 = "39c250852fb455e5de18f836c0c339075d6e52ea5ec52a76d62ef9e2eed56337",
        strip_prefix = "bazel_shlib-0.2.1",
        urls = ["https://github.com/cgrindel/bazel_shlib/archive/v0.2.1.tar.gz"],
    )
