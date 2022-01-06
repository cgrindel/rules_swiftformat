load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@cgrindel_rules_spm//spm:defs.bzl", "spm_pkg", "spm_repositories")

def swiftformat_load_package(version = None):
    """Loads SwiftFormat using Swift Package Manager via `rules_spm`.

    If a version is not specified, Swift Package Manager will be configured to \
    load the latest release.

    Args:
        version: Optional. A valid semver `string` for SwiftFormat.
    """
    spm_pkg_args = {
        "url": "https://github.com/nicklockwood/SwiftFormat.git",
        "products": ["swiftformat"],
    }
    if version == None:
        # Load the latest 0.x.x version of SwiftFormat.
        spm_pkg_args["from_version"] = "0.0.0"
    else:
        # Load the specified version of SwiftFormat
        spm_pkg_args["exact_version"] = version

    maybe(
        spm_repositories,
        name = "swiftformat_repos",
        dependencies = [
            spm_pkg(**spm_pkg_args),
        ],
        platforms = [".macOS(.v10_12)"],
    )
