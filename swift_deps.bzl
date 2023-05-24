load("@rules_swift_package_manager//swiftpkg:defs.bzl", "swift_package")

"""Swift Dependencies"""

def swift_dependencies():
    # version: 0.51.10
    swift_package(
        name = "swiftpkg_swiftformat",
        commit = "f9dc4ddc78ef09d58abb0f5aa8fb855282f4dfaa",
        dependencies_index = "@//:swift_deps_index.json",
        remote = "https://github.com/nicklockwood/SwiftFormat",
    )
