workspace(name = "cgrindel_rules_swiftformat")

load("//swiftformat:deps.bzl", "swiftformat_rules_dependencies")

swiftformat_rules_dependencies()

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

load(
    "@cgrindel_rules_updatesrc//updatesrc:deps.bzl",
    "updatesrc_rules_dependencies",
)

updatesrc_rules_dependencies()

load("@cgrindel_bazel_doc//bazeldoc:deps.bzl", "bazeldoc_dependencies")

bazeldoc_dependencies()

load(
    "@cgrindel_rules_spm//spm:deps.bzl",
    "spm_rules_dependencies",
)

spm_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()

load(
    "@build_bazel_rules_swift//swift:extras.bzl",
    "swift_rules_extra_dependencies",
)

swift_rules_extra_dependencies()

load("@cgrindel_rules_bzlformat//bzlformat:deps.bzl", "bzlformat_rules_dependencies")

bzlformat_rules_dependencies()

load("@cgrindel_bazel_starlib//:deps.bzl", "bazel_starlib_dependencies")

bazel_starlib_dependencies()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.2")

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# Load the SwiftFormat package

load("//swiftformat:load_package.bzl", "swiftformat_load_package")

swiftformat_load_package()
