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
        sha256 = "bae4a0f41cc5cf89f26c779fc04379f09bb290b4910b2cf206c0372ad0c8aac7",
        strip_prefix = "bazel-doc-0.1.0",
        urls = ["https://github.com/cgrindel/bazel-doc/archive/v0.1.0.tar.gz"],
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
        name = "cgrindel_rules_bzlformat",
        sha256 = "b45b392613092b42c4ee94051be104b990e3c8651dea17410dfd63b98957cd57",
        strip_prefix = "rules_bzlformat-0.1.0",
        urls = ["https://github.com/cgrindel/rules_bzlformat/archive/v0.1.0.tar.gz"],
    )

    # TODO: FIXME
    maybe(
        native.local_repository,
        name = "cgrindel_rules_bazel_integration_test",
        path = "/Users/chuck/code/cgrindel/rules_bazel_integration_test",
    )
