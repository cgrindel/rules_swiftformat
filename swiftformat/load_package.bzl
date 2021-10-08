load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@cgrindel_rules_spm//spm:spm.bzl", "spm_pkg", "spm_repositories")

def swiftformat_load_package():
    maybe(
        spm_repositories,
        name = "swiftformat_repos",
        dependencies = [
            spm_pkg(
                "https://github.com/nicklockwood/SwiftFormat.git",
                from_version = "0.0.0",
                products = ["swiftformat"],
            ),
        ],
        platforms = [".macOS(.v10_12)"],
    )
