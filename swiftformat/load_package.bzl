load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@cgrindel_rules_spm//spm:spm.bzl", "spm_pkg", "spm_repositories")

def swiftformat_load_package(version = None):
    spm_pkg_args = {
        "url": "https://github.com/nicklockwood/SwiftFormat.git",
        "products": ["swiftformat"],
    }
    if version == None:
        spm_pkg_args["from_version"] = "0.0.0"
    else:
        spm_pkg_args["exact_version"] = version

    maybe(
        spm_repositories,
        name = "swiftformat_repos",
        dependencies = [
            spm_pkg(**spm_pkg_args),
        ],
        platforms = [".macOS(.v10_12)"],
    )
